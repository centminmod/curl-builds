#!/bin/bash
###########################################
# EL8 & EL9 curl HTTP/3 build
###########################################

set -e

# Set TMPDIR
mkdir -p /home/buildtmp
chmod 1777 /home/buildtmp/
export TMPDIR=/home/buildtmp/

# Install dependencies
sudo dnf install -y cmake3 ninja-build clang perl golang autoconf libtool pkg-config make gcc gcc-c++ glibc-static \
    openldap-clients openldap-devel libxml2-devel libidn2-devel libnghttp2-devel libev-devel jemalloc-devel \
    c-ares-devel libunistring-devel libmetalink-devel libssh2-devel libpsl-devel openssl-devel nghttp2-devel \
    cargo --skip-broken
echo

# Define directories
BUILD_DIR=$(mktemp -d)
BUILD_QUICTLS='y'
BUILD_NGHTTP3='y'
BUILD_NGTCP2='y'
QUICTL_VERSION="openssl-3.1.5+quic"
QUICTL_REPO="https://github.com/quictls/openssl"
CURL_REPO="https://github.com/curl/curl"
NGHTTP3_VERSION="v1.1.0"
NGHTTP3_REPO="https://github.com/ngtcp2/nghttp3"
NGTCP2_VERSION="v1.5.0"
NGTCP2_REPO="https://github.com/ngtcp2/ngtcp2"
BROTLI_VERSION="v1.0.9"
BROTLI_REPO="https://github.com/google/brotli"
ZSTD_VERSION="v1.5.6"
ZSTD_REPO="https://github.com/facebook/zstd"
QUICTL_DIR=${BUILD_DIR}/quictls
NGHTTP3_DIR=${BUILD_DIR}/nghttp3
NGTCP2_DIR=${BUILD_DIR}/ngtcp2
CURL_DIR=${BUILD_DIR}/curl
BROTLI_DIR=${BUILD_DIR}/brotli
ZSTD_DIR=${BUILD_DIR}/zstd

if [ ! -d "$QUICTL_DIR" ]; then
    BUILD_QUICTLS='y'
fi

# Function to clean up installation directories
clean_install_dirs() {
    if [[ "$BUILD_QUICTLS" = [yY] ]]; then
        sudo rm -rf ${QUICTL_DIR} ${NGHTTP3_DIR} ${NGTCP2_DIR} ${CURL_DIR} ${BROTLI_DIR} ${ZSTD_DIR}
    else
        sudo rm -rf ${NGHTTP3_DIR} ${NGTCP2_DIR} ${CURL_DIR} ${BROTLI_DIR} ${ZSTD_DIR}
    fi
}

# Clean up installation directories if they exist
clean_install_dirs

if [ -f /opt/rh/gcc-toolset-13/root/usr/bin/gcc ]; then
    source /opt/rh/gcc-toolset-13/enable
fi

# Ensure environment variables
unset CC
unset CXX
export CC="ccache gcc"
export CXX="ccache g++"

if [[ "$BUILD_QUICTLS" = [yY] ]]; then
    # Compile quictls (OpenSSL with QUIC support)
    echo
    echo "Compiling quictls..."
    pushd "${BUILD_DIR}"
    git clone --depth 1 -b ${QUICTL_VERSION} ${QUICTL_REPO}
    cd openssl
    ./config enable-tls1_3 --prefix=/usr/local/quictls
    make -j$(nproc)
    sudo make install
    popd
fi

unset CC
unset CXX
export CC=gcc
export CXX=g++

if [[ "$BUILD_NGHTTP3" = [yY] ]]; then
    # Compile nghttp3
    echo
    echo "Compiling nghttp3..."
    pushd "${BUILD_DIR}"
    git clone -b ${NGHTTP3_VERSION} ${NGHTTP3_REPO}
    cd nghttp3
    git submodule update --init
    autoreconf -fi
    ./configure --prefix=/usr/local/nghttp3 --enable-lib-only
    make -j$(nproc)
    sudo make install
    popd
fi

if [[ "$BUILD_NGTCP2" = [yY] ]]; then
    # Compile ngtcp2
    echo
    echo "Compiling ngtcp2..."
    pushd "${BUILD_DIR}"
    git clone -b ${NGTCP2_VERSION} ${NGTCP2_REPO}
    cd ngtcp2
    autoreconf -fi
    ./configure PKG_CONFIG_PATH=/usr/local/quictls/lib64/pkgconfig:/usr/local/nghttp3/lib/pkgconfig \
        LDFLAGS="-Wl,-rpath,/usr/local/quictls/lib64" --prefix=/usr/local/ngtcp2 --enable-lib-only
    make -j$(nproc)
    sudo make install
    popd
fi

unset CC
unset CXX
export CC="ccache gcc"
export CXX="ccache g++"

# Compile Brotli
echo
echo "Compiling Brotli..."
pushd "${BUILD_DIR}"
git clone --branch ${BROTLI_VERSION} ${BROTLI_REPO}
cd brotli
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/brotli -DBUILD_SHARED_LIBS=OFF ..
make -j$(nproc)
sudo make install
popd

# Compile zstd
echo
echo "Compiling zstd..."
pushd "${BUILD_DIR}"
git clone --branch ${ZSTD_VERSION} ${ZSTD_REPO}
cd zstd
make -j$(nproc)
sudo make install
popd

# Compile curl
echo
echo "Compiling curl..."
pushd "${BUILD_DIR}"
git clone ${CURL_REPO}
cd curl

# Ensure the configure script is generated
autoreconf -fi

# Check if gcc works
echo
gcc --version
echo
g++ --version

# Set PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/quictls/lib64/pkgconfig:/usr/local/nghttp3/lib/pkgconfig:/usr/local/ngtcp2/lib/pkgconfig:/usr/local/brotli/lib64/pkgconfig:/usr/local/lib/pkgconfig

# Set LDFLAGS and CPPFLAGS
LDFLAGS="-Wl,-rpath,/usr/local/quictls/lib64:/usr/local/ngtcp2/lib:/usr/local/nghttp3/lib:/usr/local/brotli/lib64:/usr/local/lib -L/usr/local/quictls/lib64 -L/usr/local/ngtcp2/lib -L/usr/local/nghttp3/lib -L/usr/local/brotli/lib64 -L/usr/local/lib"
CPPFLAGS="-I/usr/local/quictls/include -I/usr/local/ngtcp2/include -I/usr/local/nghttp3/include -I/usr/local/brotli/include -I/usr/local/include"
LIBS="-lbrotlidec-static -lbrotlicommon-static -lbrotlienc-static -lzstd"

# Ensure that the static libraries are found
if [ ! -f /usr/local/brotli/lib64/libbrotlidec-static.a ] || [ ! -f /usr/local/brotli/lib64/libbrotlicommon-static.a ] || [ ! -f /usr/local/brotli/lib64/libbrotlienc-static.a ]; then
    echo "Brotli static libraries not found. Please check the installation."
    exit 1
fi

# Configure curl
./configure LDFLAGS="${LDFLAGS}" CPPFLAGS="${CPPFLAGS}" LIBS="${LIBS}" \
    --with-openssl=/usr/local/quictls \
    --with-nghttp3=/usr/local/nghttp3 \
    --with-ngtcp2=/usr/local/ngtcp2 \
    --disable-shared \
    --enable-static \
    --with-brotli=/usr/local/brotli \
    --with-zstd=/usr/local \
    --with-libssh2 \
    --enable-alt-svc

make -j$(nproc)
sudo make install
popd

echo
/usr/local/bin/curl -V

# Clean up
rm -rf "${BUILD_DIR}"

echo "curl static binary with HTTP/2 and HTTP/3 support built and installed in /usr/local/bin/curl"
