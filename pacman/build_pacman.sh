ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# ALTER THIS FOR INSTALL OF BIN, ETC, LIB...
INSTALL_PATH=$ROOT_DIR/aarch64
# ALTER THIS TO SET WHERE PACKAGES ARE INSTALLED
PACMAN_PACKAGE_ROOT=$INSTALL_PATH/sysroot
PARALLEL_MAKE=-j4
export PATH=$INSTALL_PATH/bin:$PATH

PACMAN_VERSION=pacman-5.1.3
if [ ! -d ${PACMAN_VERSION} ]; then
    wget https://sources.archlinux.org/other/pacman/${PACMAN_VERSION}.tar.gz \
    --directory-prefix=${DEPENDENCIES_PATH} 
    tar zxf ${PACMAN_VERSION}.tar.gz
fi

if [ ! -d ${PACMAN_PACKAGE_ROOT} ]; then
    mkdir -p $PACMAN_PACKAGE_ROOT
fi

cd ${PACMAN_VERSION}
./configure --prefix=${INSTALL_PATH} \
    --exec-prefix=${INSTALL_PATH} \
    --with-root-dir=${PACMAN_PACKAGE_ROOT}
make ${PARALLEL_MAKE} install

cp ${ROOT_DIR}/pacman_support/makepkg_arm8.conf  ${INSTALL_PATH}/etc/makepkg.conf
tail -n 25 ${ROOT_DIR}/pacman_support/pacman_sketch.conf | \
    sed -e "s|TARGET_ROOT|$INSTALL_PATH|g" >> ${INSTALL_PATH}/etc/pacman.conf

# EDIT THIS VARIABLE TP SPECIFY ARCHTECTURE (auto works if native architecture match what you want)
sed -i -e 's/auto/aarch64/g' ${INSTALL_PATH}/etc/pacman.conf

if [ ! -d ${INSTALL_PATH}/etc/pacman.d ]; then
    mkdir ${INSTALL_PATH}/etc/pacman.d
fi

cp ${ROOT_DIR}/pacman_support/mirrorlist ${INSTALL_PATH}/etc/pacman.d/
sudo pacman-key --init 

#cd ${DEPENDENCIES_PATH}
if [ ! -d archlinuxarm-keyring ]; then
    git clone https://github.com/archlinuxarm/archlinuxarm-keyring
fi
cd archlinuxarm-keyring
make PREFIX=${INSTALL_PATH} install

#sudo pacman-key --populate archlinuxarm
#sudo pacman -Sy

# IMPLEMENT SYMLINKING IN THIS WAY:
# After updating database, make usr/bin, usr/lib in root, then move bin and lib to respectibly folders
# Now remove bin, lib. 
# This because arch linux uses this structure, and packages will fail to install if it finds bin or lib
# in root folder.
# When installing the first package (can be any), the system will make the symlink themselves

