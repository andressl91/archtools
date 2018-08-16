#!/bin/bash

echo "Hello"
echo "$(dirname $(readlink -f $0)) "
install_folder=$(dirname $(readlink -f $0)) 

pacman_install=$install_folder/pacman


pacman -S --needed - < $pacman_install/package_list.txt

echo $install_folder

echo "${HOME}"
