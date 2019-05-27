#! /bin/bash
set -e
trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
trap 'echo FAILED COMMAND: $previous_command' EXIT

#-------------------------------------------------------------------------------------------
# This script will download packages for, configure, build and install a GCC cross-compiler.
# Customize the variables (INSTALL_PATH, TARGET, etc.) to your liking before running.
# If you get an error and need to resume the script from some point in the middle,
# just delete/comment the preceding lines before running it again.
#
# See: http://preshing.com/20141119/how-to-build-a-gcc-cross-compiler
#-------------------------------------------------------------------------------------------

TARGET=aarch64-unknown-linux-gnu
INSTALL_PATH=/opt/manualcross/${TARGET}
USE_NEWLIB=0
LINUX_ARCH=arm64
CONFIGURATION_OPTIONS="--disable-multilib" # --disable-threads --disable-shared
BINUTILS_VERSION=binutils-2.32
GCC_VERSION=gcc-8.3.0 # error in final step, might be due to bleeding edge GCC
#GCC_VERSION=gcc-9.1.0 # error in final step, might be due to bleeding edge GCC
LINUX_KERNEL_VERSION=linux-5.0.1
GLIBC_VERSION=glibc-2.29
MPFR_VERSION=mpfr-4.0.2
GMP_VERSION=gmp-6.1.2
MPC_VERSION=mpc-1.1.0
ISL_VERSION=isl-0.18
CLOOG_VERSION=cloog-0.18.1
PARALLEL_MAKE=-j4
LANGUAGES="c,c++"
export PATH=$INSTALL_PATH/bin:$PATH

# Download packages
function download {
    export http_proxy=$HTTP_PROXY https_proxy=$HTTP_PROXY ftp_proxy=$HTTP_PROXY
    wget -nc https://ftp.gnu.org/gnu/binutils/$BINUTILS_VERSION.tar.gz
    wget -nc https://ftp.gnu.org/gnu/gcc/$GCC_VERSION/$GCC_VERSION.tar.gz
    if [ $USE_NEWLIB -ne 0 ]; then
        wget -nc -O newlib-master.zip https://github.com/bminor/newlib/archive/master.zip || true
        unzip -qo newlib-master.zip
    else
        wget -nc https://www.kernel.org/pub/linux/kernel/v5.x/$LINUX_KERNEL_VERSION.tar.xz
        wget -nc https://ftp.gnu.org/gnu/glibc/$GLIBC_VERSION.tar.xz
    fi
    wget -nc https://ftp.gnu.org/gnu/mpfr/$MPFR_VERSION.tar.xz
    wget -nc https://ftp.gnu.org/gnu/gmp/$GMP_VERSION.tar.xz
    wget -nc https://ftp.gnu.org/gnu/mpc/$MPC_VERSION.tar.gz
    wget -nc ftp://gcc.gnu.org/pub/gcc/infrastructure/$ISL_VERSION.tar.bz2
    wget -nc ftp://gcc.gnu.org/pub/gcc/infrastructure/$CLOOG_VERSION.tar.gz

    # Extract everything
    for f in *.tar*; do tar xfk $f; done
    for f in *.tar*; do rm -rf  $f; done
}

# download

# Make symbolic links: https://gcc.gnu.org/install/download.html
# In short, if deps/compiler optimzers libs are in GCC dir, they are used
cd ${GCC_VERSION}
ln -sf `ls -1d ../mpfr-*/` mpfr
ln -sf `ls -1d ../gmp-*/` gmp
ln -sf `ls -1d ../mpc-*/` mpc
ln -sf `ls -1d ../isl-*/` isl
ln -sf `ls -1d ../cloog-*/` cloog
cd ..

# Step 1. Binutils
mkdir build-binutils && cd build-binutils
../$BINUTILS_VERSION/configure \
                    --prefix=$INSTALL_PATH \
                    --target=$TARGET \
                    --disable-nls # tells binutils not to include native language support. 
make ${PARALLEL_MAKE}
make install
echo Binutils built and installed.
cd ..

# Step 2. Linux Kernel Headers
cd $LINUX_KERNEL_VERSION
make ARCH=$LINUX_ARCH INSTALL_HDR_PATH=$INSTALL_PATH/$TARGET headers_install
echo Created linux root with headers.
cd ..
# GCC now requires the GMP, MPFR and MPC packages. 
# As these packages may not be included in your host distribution, they will be built with GCC. 
# Unpack each package into the GCC source directory and rename the resulting directories so the GCC build procedures will automatically use them: 

 #--disable-decimal-float, --disable-threads, --disable-libatomic, --disable-libgomp, --disable-libquadmath, --disable-libssp, --disable-libvtv, --disable-libstdcxx

#    These switches disable support for the decimal floating point extension, threading, libatomic, libgomp, libquadmath, libssp, libvtv, and the C++ standard library respectively. These features will fail to compile when building a cross-compiler and are not necessary for the task of cross-compiling the temporary libc.


#    --with-sysroot=$LFS                            \

# Step 3. C/C++ Compilers
mkdir -p build-gcc && cd build-gcc
../$GCC_VERSION/configure                          \
    --prefix=$INSTALL_PATH                         \
    --target=$TARGET                               \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++

make ${PARALLEL_MAKE} all-gcc
make install-gcc

cd .. 

# Step 4. Standard C library headers
mkdir -p build-glibc
cd build-glibc
../${GLIBC_VERSION}/configure \
                --prefix=$INSTALL_PATH/$TARGET \ 
                --build=$MACHTYPE \
                --host=$TARGET \ #SHOULD BE TARGET OR MACHTYPE?
                --target=$TARGET \
                --with-headers=$INSTALL_PATH/$TARGET/include \
                --disable-multilib \
                libc_cv_forced_unwind=yes

make install-bootstrap-headers=yes install-headers
make $PARALLEL_MAKE csu/subdir_lib
install csu/crt1.o csu/crti.o csu/crtn.o $INSTALL_PATH/$TARGET/lib
$TARGET-gcc -nostdlib -nostartfiles -shared -x c /dev/null -o $INSTALL_PATH/$TARGET/lib/libc.so
touch /opt/cross/aarch64-linux/include/gnu/stubs.h
cd ..

# Step 5.  Compiler support library
cd build-gcc
make ${PARALLEL_MAKE} all-target-libgcc
make install-target-libgcc
cd ..

# Step 6. Standard C Library & rest of Glibc
cd build-glibc
make ${PARALLEL_MAKE}
make install
cd ..

cd build-gcc
make ${PARALLEL_MAKE} all
make install
cd ..
