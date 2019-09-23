#!/bin/bash

#CHINX_SCRIPT=$(readlink -f $0)
#echo ${SCRIPT}
UTILITIES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export CROSS_ENVIRONMENT_ROOT="$(cd ${UTILITIES_DIR}/../ && pwd)"
CROSS_COMPILE_BIN=${CROSS_ENVIRONMENT_ROOT}/bin


export ARCHITECTURE="aarch64-unknown-linux-gnu"
export TARGET_ROOT=${CROSS_ENVIRONMENT_ROOT}/${ARCHITECTURE}

export PATH=${CROSS_COMPILE_BIN}:$PATH
export PACMAN_CONFIG_PATH=${TARGET_ROOT}/etc/pacman.conf
export MAKEPKG_CONFIG_PATH=${TARGET_ROOT}/etc/makepkg.conf

# TODO: Use sed to make custom chinx.sh 
#sed -e "s|TARGET_ROOT|$TARGET_ROOT|g" ./pacman_support/pacman_env_var.conf > ./pacman_support/foo.config

function pacman {
    command pacman --config=${PACMAN_CONFIG_PATH} $*
}

function spacman {
    command sudo pacman --config=${PACMAN_CONFIG_PATH} $*
}

function makepkg {
    command makepkg --config={PACMAN_CONFIG_PATH} $*
}

function cmake {
    TOOLCHAIN_CMAKE_FILE=${CROSS_ENVIRONMENT_ROOT}/utilities/cross_arm64.cmake
    command cmake -DCMAKE_TOOLCHAIN_FILE=${UTILITIES_DIR}/cross_arm64.cmake $*
}


