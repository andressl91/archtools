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

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TARGET=aarch64-unknown-linux-gnu
TARGET_ARCHITECTURE=armv8-a
INSTALL_PATH=$HOME/sandbox/pacman
DEPENDENCIES_PATH=$INSTALL_PATH/dependencies
LINUX_ARCH=arm64
CONFIGURATION_OPTIONS="--disable-multilib" # --disable-threads --disable-shared
PARALLEL_MAKE=-j3
PACMAN_VERSION=pacman-5.1.3

mkdir -p $INSTALL_PATH

export http_proxy=$HTTP_PROXY https_proxy=$HTTP_PROXY ftp_proxy=$HTTP_PROXY
cd ${INSTALL_PATH}
ls
echo ${PACMAN_VERSION}.tar.gz

if [ ! -f ${PACMAN_VERSION}.tar.gz ]; then
    wget https://sources.archlinux.org/other/pacman/${PACMAN_VERSION}.tar.gz \
    --directory-prefix=${INSTALL_PATH} 
fi

tar zxf ${PACMAN_VERSION}.tar.gz

#if [ ! -d ${INSTALL_PATH}/pacman_root ]; then
#    mkdir ${INSTALL_PATH}/pacman_root
#fi

#--with-root-dir=${INSTALL_PATH}/pacman_root 
cd ${PACMAN_VERSION}
./configure --prefix=${INSTALL_PATH} \
    --exec-prefix=${INSTALL_PATH} \
    --with-root-dir=${INSTALL_PATH}
make ${PARALLEL_MAKE} install

#sed -e "s|INSTALL_PATH|$INSTALL_PATH|g" ${SCRIPT_DIR}/pacman_support/pacman_sketch.conf > ${INSTALL_PATH}/etc/pacman.conf

cp ${SCRIPT_DIR}/makepkg_arm8.conf  ${INSTALL_PATH}/etc/makepkg.conf
tail -n 25 ${SCRIPT_DIR}/pacman_sketch.conf | \
    sed -e "s|TARGET_ROOT|$INSTALL_PATH/pacman_root|g" >> ${INSTALL_PATH}/etc/pacman.conf

# IF OTHER ARCHITECTURE, edit here. Example for armv8 provided. If host just comment out
sed -i -e 's/auto/aarch64/g' ${INSTALL_PATH}/etc/pacman.conf

if [ ! -d ${INSTALL_PATH}/etc/pacman.d ]; then
    mkdir ${INSTALL_PATH}/etc/pacman.d
fi

cp ${SCRIPT_DIR}/mirrorlist ${INSTALL_PATH}/etc/pacman.d/
sudo pacman-key --init 

cd ${INSTALL_PATH}
if [ ! -d archlinuxarm-keyring ]; then
    git clone https://github.com/archlinuxarm/archlinuxarm-keyring
fi
cd archlinuxarm-keyring
make PREFIX=${INSTALL_PATH} install

sudo pacman-key --populate archlinuxarm
sudo pacman -Sy
# IMPLEMENT SYMLINKING IN THIS WAY:
# After updating database, make usr/bin, usr/lib in root, then move bin and lib to respectibly folders
# Now remove bin, lib. 
# This because arch linux uses this structure, and packages will fail to install if it finds bin or lib
# in root folder.
# When installing the first package (can be any), the system will make the symlink themselves


echo DONE 
