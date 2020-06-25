#!/bin/bash

TARGET_ROOT=FOO
sed -e "s|TARGET_ROOT|$TARGET_ROOT|g" pacman_sketch.conf
