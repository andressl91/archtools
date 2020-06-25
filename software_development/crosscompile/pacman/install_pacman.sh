#!/bin/bash

# Download sourcecode
PACMAN_VERSION=5.1.3
wget https://sources.archlinux.org/other/pacman/pacman-${PACMAN_VERSION}.tar.gz
tar xf pacman-${PACMAN_VERSION}.tar.gz

export TARGET_ROOT=/home/jackal/Downloads/fakeroot
# THOUGHT, set prefix to one level up in the current chinx build tree
cd pacman-${PACMAN_VERSION}
./configure --prefix=${TARGET_ROOT} \
            --with-root-dir=${TARGET_ROOT}
make install

cd ..
git clone https://github.com/archlinuxarm/archlinuxarm-keyring.git
cd archlinuxarm-keyring
make PREFIX=${TARGET_ROOT} install

export PATH=${TARGET_ROOT}/bin:$PATH

sudo pacman-key --init
sudo pacman-key --populate archlinuxarm

# NOTE BEFORE SYNCING DATABASES, check pacman.conf or pacman -v
# MUST! Change Architecture to aarch64 in pacman.conf, use .conf from downloaded root as ref

# HERE MIRRORREF MUST BE ADDED IN DEFAULT pacman.conf
# MABY  echo ... >> pacman.conf could be it (2x >> appends ??)


sudo pacman -Syy

