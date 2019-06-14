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

####### TERMINAL ######
# urxvt
sudo pacman -S rxvt-unicode
echo COPYING URXVT CONFIG FILE TO $HOME/.Xdefaults
cp -r $install_folder/urxvt/.Xdefaults $HOME/
mkdir -p $HOME/.urxvt/etx && cp $install_folder/urxvt/scripts/* $HOME/.urxvt/etx

# bash
cp $install_folder/bash/.bashrc $HOME/



######## SYSTEM #########
sudo pacman -S htop openssh
ssh-keygen -t rsa -b 4096

# Make ssh-key
ssss

# Internet browser
sudo pacman -S firefox


######## PRIVACY #########
# Macchanger
sudo pacman -S macchanger
# VPN
sudo pacman -S openresolv
sudo pacman -S openvn
sudo cp ${install_folder}/openvpn/update-resolv-conf /etc/openvpn/
