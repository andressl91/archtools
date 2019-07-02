#!/bin/bash

CROSS_COMPILE_ROOT=/home/jackal/arm64cross/aarch64-unknown-linux-gnu
CROSS_COMPILE_BIN=${CROSS_COMPILE_ROOT}/bin

TARGET_ROOT=/home/jackal/arm64cross/aarch64-unknown-linux-gnu/aarch64-unknown-linux-gnu/
ARM_PACMAN_CONFIG=${TARGET_ROOT}/etc/pacman.conf
TOOLCHAIN_CMAKE_FILE=/

function chinx() {
    export PATH=${CROSS_COMPILE_BIN}:$PATH
    alias pacman="pacman --config=$ARM_PACMAN_CONFIG"
    alias cmake="cmake -DCMAKE_TOOLCHAIN_FILE=${CROSS_COMPILE_ROOT}/utilities/cross_arm64.cmake"
}
