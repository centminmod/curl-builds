#!/bin/bash
###########################################
# EL8 & EL9 curl HTTP/3 build
###########################################
set -e  # Exit immediately if any command fails

# Set TMPDIR for temporary build files
mkdir -p /home/buildtmp
chmod 1777 /home/buildtmp/
export TMPDIR=/home/buildtmp/
echo
echo "set $TMPDIR"
echo "TMPDIR=$TMPDIR"
echo

# Define directories and versions for the build components
BUILD_DIR=$(mktemp -d ${TMPDIR}/build-XXXXXXXXXX)
BUILD_QUICTLS='y'
BUILD_NGHTTP3='y'
BUILD_NGTCP2='y'
BUILD_STATIC_OPENSSL='y'
QUICTL_VERSION="openssl-3.1.5+quic"
QUICTL_REPO="https://github.com/quictls/openssl"
CURL_REPO="https://github.com/curl/curl"
NGHTTP3_VERSION="v1.3.0"
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

INSTALL_PREFIX="/opt/curl-quictls"  # Set the installation prefix for all components

# Function to check if a package is installed
is_package_installed() {
    rpm -q "$1" >/dev/null 2>&1
}

# List of packages to install
packages=(
    cmake3 ninja-build clang perl golang autoconf libtool pkg-config make gcc gcc-c++ glibc-static
    openldap-clients openldap-devel libxml2-devel libidn2-devel libnghttp2-devel libev-devel jemalloc-devel
    c-ares-devel libunistring-devel libmetalink-devel libssh2-devel libpsl-devel openssl-devel nghttp2-devel
    cargo
)

# Array to store packages that need to be installed
packages_to_install=()

# Check each package and add it to packages_to_install if not already installed
for package in "${packages[@]}"; do
    if ! is_package_installed "$package"; then
        packages_to_install+=("$package")
    fi
done

# Install packages that are not already installed
if [ ${#packages_to_install[@]} -gt 0 ]; then
    echo "Installing required packages..."
    sudo dnf install -y "${packages_to_install[@]}" --skip-broken
else
    echo "All required packages are already installed."
fi
echo

# Check if quictls directory exists, set BUILD_QUICTLS flag accordingly
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

# Enable gcc-toolset-13 if available
if [ -f /opt/rh/gcc-toolset-13/root/usr/bin/gcc ]; then
    source /opt/rh/gcc-toolset-13/enable
fi
# Enable gcc-toolset-12 if available
if [ -f /opt/rh/gcc-toolset-12/root/usr/bin/gcc ]; then
    source /opt/rh/gcc-toolset-12/enable
fi
# Enable gcc-toolset-11 if available
if [ -f /opt/rh/gcc-toolset-11/root/usr/bin/gcc ]; then
    source /opt/rh/gcc-toolset-11/enable
fi

# Ensure environment variables for compiler are set correctly
unset CC
unset CXX
export CC="ccache gcc"
export CXX="ccache g++"

# Compile quictls (OpenSSL with QUIC support) if BUILD_QUICTLS flag is set
if [[ "$BUILD_QUICTLS" = [yY] ]]; then
    echo
    echo "Compiling quictls..."
    pushd "${BUILD_DIR}"
    git clone --depth 1 -b ${QUICTL_VERSION} ${QUICTL_REPO}
    cd openssl
    ./config enable-tls1_3 --prefix=${INSTALL_PREFIX}/quictls
    make -j$(nproc)
    sudo make install
    popd
fi

# Compile static 64-bit quicTLS (OpenSSL) if BUILD_STATIC_OPENSSL flag is set
if [[ "$BUILD_STATIC_OPENSSL" = [yY] ]]; then
    echo
    echo "Compiling static quicTLS..."
    mkdir -p "${BUILD_DIR}/openssl"
    pushd "${BUILD_DIR}/openssl"
    ./config enable-tls1_3 -static --prefix=${INSTALL_PREFIX}/quictls-static
    make clean
    make -j$(nproc)
    sudo make install
    popd
fi

# Reset compiler environment variables
unset CC
unset CXX
export CC=gcc
export CXX=g++

# Compile nghttp3 if BUILD_NGHTTP3 flag is set
if [[ "$BUILD_NGHTTP3" = [yY] ]]; then
    echo
    echo "Compiling nghttp3..."
    pushd "${BUILD_DIR}"
    git clone -b ${NGHTTP3_VERSION} ${NGHTTP3_REPO}
    cd nghttp3
    git submodule update --init
    autoreconf -fi
    ./configure --prefix=${INSTALL_PREFIX}/nghttp3 --enable-lib-only
    make -j$(nproc)
    sudo make install
    popd
fi

# Compile ngtcp2 if BUILD_NGTCP2 flag is set
if [[ "$BUILD_NGTCP2" = [yY] ]]; then
    echo
    echo "Compiling ngtcp2..."
    pushd "${BUILD_DIR}"
    git clone -b ${NGTCP2_VERSION} ${NGTCP2_REPO}
    cd ngtcp2
    autoreconf -fi
    ./configure PKG_CONFIG_PATH=${INSTALL_PREFIX}/quictls/lib64/pkgconfig:${INSTALL_PREFIX}/nghttp3/lib/pkgconfig \
        LDFLAGS="-Wl,-rpath,${INSTALL_PREFIX}/quictls/lib64" --prefix=${INSTALL_PREFIX}/ngtcp2 --enable-lib-only
    make -j$(nproc)
    sudo make install
    popd
fi

# Set compiler environment variables again
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
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}/brotli -DBUILD_SHARED_LIBS=OFF ..
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
sudo make install PREFIX=${INSTALL_PREFIX}/zstd
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

# Set PKG_CONFIG_PATH to include the paths for the compiled dependencies
export PKG_CONFIG_PATH=${INSTALL_PREFIX}/quictls/lib64/pkgconfig:${INSTALL_PREFIX}/nghttp3/lib/pkgconfig:${INSTALL_PREFIX}/ngtcp2/lib/pkgconfig:${INSTALL_PREFIX}/brotli/lib64/pkgconfig:${INSTALL_PREFIX}/zstd/lib/pkgconfig

# Set LDFLAGS and CPPFLAGS to include the paths for the compiled dependencies
LDFLAGS="-Wl,-rpath,${INSTALL_PREFIX}/quictls/lib64:${INSTALL_PREFIX}/ngtcp2/lib:${INSTALL_PREFIX}/nghttp3/lib:${INSTALL_PREFIX}/brotli/lib64:${INSTALL_PREFIX}/zstd/lib -L${INSTALL_PREFIX}/quictls/lib64 -L${INSTALL_PREFIX}/ngtcp2/lib -L${INSTALL_PREFIX}/nghttp3/lib -L${INSTALL_PREFIX}/brotli/lib64 -L${INSTALL_PREFIX}/zstd/lib"
CPPFLAGS="-I${INSTALL_PREFIX}/quictls/include -I${INSTALL_PREFIX}/ngtcp2/include -I${INSTALL_PREFIX}/nghttp3/include -I${INSTALL_PREFIX}/brotli/include -I${INSTALL_PREFIX}/zstd/include"
LIBS="-lbrotlidec-static -lbrotlicommon-static -lbrotlienc-static -lzstd"

# Ensure that the static libraries for Brotli are found, exit if not found
if [ ! -f ${INSTALL_PREFIX}/brotli/lib64/libbrotlidec-static.a ] || [ ! -f ${INSTALL_PREFIX}/brotli/lib64/libbrotlicommon-static.a ] || [ ! -f ${INSTALL_PREFIX}/brotli/lib64/libbrotlienc-static.a ]; then
    echo "Brotli static libraries not found. Please check the installation."
    exit 1
fi

# Configure curl with the compiled dependencies and required options
./configure LDFLAGS="${LDFLAGS}" CPPFLAGS="${CPPFLAGS}" LIBS="${LIBS}" \
    --with-openssl=${INSTALL_PREFIX}/quictls \
    --with-nghttp3=${INSTALL_PREFIX}/nghttp3 \
    --with-ngtcp2=${INSTALL_PREFIX}/ngtcp2 \
    --disable-shared \
    --enable-static \
    --with-brotli=${INSTALL_PREFIX}/brotli \
    --with-zstd=${INSTALL_PREFIX}/zstd \
    --with-libssh2 \
    --enable-alt-svc

# Build and install curl
make -j$(nproc)
sudo make install
popd

# Check static quicTLS OpenSSL binary
echo
ldd "${INSTALL_PREFIX}/quictls-static/bin/openssl"
echo
${INSTALL_PREFIX}/quictls-static/bin/openssl version -a

# Check quicTLS OpenSSL binary supported ciphers
echo
${INSTALL_PREFIX}/quictls-static/bin/openssl ciphers -V 'ALL:COMPLEMENTOFALL'

# Check curl build
echo
ldd /usr/local/bin/curl

# Print the version of the installed curl binary
echo
/usr/local/bin/curl -V

# Clean up the temporary build directory
rm -rf "${BUILD_DIR}"

echo "curl with HTTP/2 and HTTP/3 support built and installed in /usr/local/bin/curl"
echo "static openssl build at ${INSTALL_PREFIX}/quictls-static/bin/openssl"