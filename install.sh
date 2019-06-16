#!/bin/bash


install_folder=$(dirname $(readlink -f $0)) 

####### Vim #######
sudo pacman -S vim vim-runtime
echo COPYING VIM CONFIG TO $HOME/.vimrc
cp $install_folder/vim/.vimrc $HOME/
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
pip install flake8
echo COPYING OLD-HOPE COLOR TO VIM CONFIG
cp -rf $install_folder/vim/autoload $HOME/.vim/
cp -rf $install_folder/vim/colors $HOME/.vim/
vim +PluginInstall +qall
youcompleteme_install=$HOME/.vim/bundle/YouCompleteMe/install.py
# IF NOT C++ needed install with  python $youcompleteme_install
python $youcompleteme_install --clang-completer
sudo pacman -S python ipython python-virtualenv

# WINDOW MANAGER i3-wm
echo COPY i3 CONFIG TO HOME DIRECTORY
cp $install_folder/i3wm/config $HOME/.config/i3

####### TERMINAL ######
# urxvt
sudo pacman -S rxvt-unicode
echo COPYING URXVT CONFIG FILE TO $HOME/.Xdefaults
cp -r $install_folder/urxvt/.Xdefaults $HOME/
mkdir -p $HOME/.urxvt/etx && cp $install_folder/urxvt/scripts/* $HOME/.urxvt/etx

# bash
echo COPYING BASHRC CONFIG FILE
cp $install_folder/bash/.bashrc $HOME/

######## SYSTEM #########
sudo pacman -S htop openssh

# Make ssh-key
echo GENERATE SSH-KEY
ssh-keygen -t rsa -b 4096

# Internet browser
sudo pacman -S firefox

######## PRIVACY #########
# VPN and macchanger
sudo pacman -S openresolv openvn macchanger
sudo cp ${install_folder}/openvpn/update-resolv-conf /etc/openvpn/
echo ADD FOLLOWING IN OPENVPN client.conf
echo script-security 2
echo up /etc/openvpn/update-resolv-conf.sh
echo down /etc/openvpn/update-resolv-conf.sh
echo down-pre

###### RICE ######
echo RICE UP THE DESKTOP
sudo pacman -S feh imagemagick python-pip python-pywal
mkdir -p $HOME/Pictures/Wallpaper
cp $install_folder/rice/leopard.png $HOME/Pictures/Wallpaper
cp $install_folder/rice/leopard.jpg $HOME/Pictures/Wallpaper
echo NOW RUN: wal -i "PATH TO IMAGE", and watch the magic


