#!/bin/bash

set -e

# Set TMPDIR
mkdir -p /home/buildtmp
chmod 1777 /home/buildtmp/
export TMPDIR=/home/buildtmp/

# Install dependencies
sudo dnf install -y cmake3 ninja-build clang perl golang autoconf libtool pkg-config make gcc gcc-c++ glibc-static \
    openldap-clients openldap-devel libxml2-devel libidn2-devel libnghttp2-devel libev-devel jemalloc-devel \
    c-ares-devel libunistring-devel libmetalink-devel libssh2-devel libpsl-devel openssl-devel nghttp2-devel \
    ngtcp2-devel nghttp3-devel cargo --skip-broken
echo

# Define directories
BUILD_DIR=$(mktemp -d)
QUIHE_VERSION="0.21.0"
QUIHE_REPO="https://github.com/cloudflare/quiche"
CURL_REPO="https://github.com/curl/curl"
QUIHE_DIR=${BUILD_DIR}/quiche
CURL_DIR=${BUILD_DIR}/curl
ZSTD_VERSION="1.5.2"
ZSTD_REPO="https://github.com/facebook/zstd"
ZSTD_DIR=${BUILD_DIR}/zstd
BROTLI_VERSION="1.0.9"
BROTLI_REPO="https://github.com/google/brotli"
BROTLI_DIR=${BUILD_DIR}/brotli

# Function to clean up installation directories
clean_install_dirs() {
    sudo rm -rf ${QUIHE_DIR} ${CURL_DIR} ${ZSTD_DIR} ${BROTLI_DIR}
}

# Clean up installation directories if they exist
clean_install_dirs

if [ -f /opt/rh/gcc-toolset-13/root/usr/bin/gcc ]; then
    source /opt/rh/gcc-toolset-13/enable
fi

# Ensure environment variables
export CC=gcc
export CXX=g++

# Compile zstd from source
echo
echo "Compiling zstd..."
pushd "${BUILD_DIR}"
git clone --branch v${ZSTD_VERSION} ${ZSTD_REPO}
cd zstd
make -j$(nproc)
sudo make install
popd

# Compile Brotli from source
echo
echo "Compiling Brotli..."
pushd "${BUILD_DIR}"
git clone --branch v${BROTLI_VERSION} ${BROTLI_REPO}
cd brotli
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=OFF ..
make -j$(nproc)
sudo make install
popd

# Verify Brotli installation
if [ ! -f /usr/local/lib64/libbrotlidec-static.a ] || [ ! -f /usr/local/lib64/libbrotlicommon-static.a ] || [ ! -f /usr/local/lib64/libbrotlienc-static.a ]; then
    echo "Brotli libraries not found in /usr/local/lib64. Please check the installation."
    exit 1
fi

# Add Brotli to PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH

# Compile quiche
echo
echo "Compiling quiche..."
pushd "${BUILD_DIR}"
git clone --recursive -b ${QUIHE_VERSION} ${QUIHE_REPO}
cd quiche
cargo build --package quiche --release --features ffi,pkg-config-meta,qlog
mkdir -p quiche/deps/boringssl/src/lib
echo "find target/release -name libcrypto.a -o -name libssl.a"
find target/release -name libcrypto.a -o -name libssl.a
ln -vnf $(find target/release -name libcrypto.a -o -name libssl.a) quiche/deps/boringssl/src/lib/
popd

# Set PKG_CONFIG_PATH
export PKG_CONFIG_PATH=${QUIHE_DIR}/quiche/deps/boringssl/src/lib/pkgconfig:${QUIHE_DIR}/target/release/pkgconfig:$PKG_CONFIG_PATH

# Set PKG_CONFIG_LIBDIR
export PKG_CONFIG_LIBDIR=${QUIHE_DIR}/quiche/deps/boringssl/src/lib/pkgconfig:${QUIHE_DIR}/target/release/pkgconfig

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

# Set LDFLAGS and CPPFLAGS
LDFLAGS="-L/usr/lib64 -L/usr/local/lib64 -L${QUIHE_DIR}/quiche/deps/boringssl/src/lib -L${QUIHE_DIR}/target/release -Wl,-rpath,${QUIHE_DIR}/target/release:/usr/local/lib64 -static"
CPPFLAGS="-I/usr/include -I/usr/local/include -I${QUIHE_DIR}/quiche/deps/boringssl/src/include -I${QUIHE_DIR}/target/release/include"
LIBS="-lbrotlidec-static -lbrotlicommon-static -lbrotlienc-static -lzstd"

# Ensure default paths are included in LDFLAGS and CPPFLAGS
LDFLAGS="${LDFLAGS} -L/usr/local/lib64 -L/usr/local/lib -L/lib -L/lib64 -L/usr/lib -L/usr/lib64"
CPPFLAGS="${CPPFLAGS} -I/usr/local/include -I/include -I/usr/include"

echo
echo "$PWD"
echo
echo "$PWD/../quiche/quiche/deps/boringssl/src"
ls -lah $PWD/../quiche/quiche/deps/boringssl/src
echo
echo "$PWD/../quiche/target/release"
ls -lah $PWD/../quiche/target/release
echo

# Configure curl
./configure LDFLAGS="${LDFLAGS}" CPPFLAGS="${CPPFLAGS}" LIBS="${LIBS}" \
    --with-openssl-quic \
    --with-openssl=$PWD/../quiche/quiche/deps/boringssl/src \
    --with-quiche=$PWD/../quiche/target/release \
    --disable-shared \
    --enable-static \
    --with-brotli \
    --with-zstd \
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
