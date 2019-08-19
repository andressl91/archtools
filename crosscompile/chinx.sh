#!/bin/bash

#CHINX_SCRIPT=$(readlink -f $0)
#echo ${SCRIPT}
UTILITIES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export CROSS_ENVIRONMENT_ROOT="$(cd ${UTILITIES_DIR}/../ && pwd)"
CROSS_COMPILE_BIN=${CROSS_ENVIRONMENT_ROOT}/bin


export ARCHITECTURE="aarch64-unknown-linux-gnu"
export TARGET_ROOT=${CROSS_ENVIRONMENT_ROOT}/${ARCHITECTURE}

export PATH=${CROSS_COMPILE_BIN}:$PATH
echo $PATH

function pacman {
    ARM_PACMAN_CONFIG=${TARGET_ROOT}/etc/pacman.conf
    command pacman --config=${ARM_PACMAN_CONFIG} $*
}

function spacman {
    ARM_PACMAN_CONFIG=${TARGET_ROOT}/etc/pacman.conf
    command sudo pacman --config=${ARM_PACMAN_CONFIG} $*
}

function cmake {
    TOOLCHAIN_CMAKE_FILE=${CROSS_ENVIRONMENT_ROOT}/utilities/cross_arm64.cmake
    command cmake -DCMAKE_TOOLCHAIN_FILE=${UTILITIES_DIR}/cross_arm64.cmake $*
}
