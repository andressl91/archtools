#!/bin/bash


install_folder=$(dirname $(readlink -f $0)) 

pacman_install=$install_folder/pacman

# Python
sudo pacman -S python
sudo pacman -S python-pip


# Vim stuff
sudo pacman -S vim
sudo pacman -S cmake
echo COPYING VIM CONFIG TO $HOME/.vimrc
cp $install_folder/vim/.vimrc $HOME/
echo INSTALLING Vundle with Plugins
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp -rf $install_folder/vim/autoload $HOME/.vim/
cp -rf $install_folder/vim/colors $HOME/.vim/
pip install flake8
echo COPYING OLD-HOPE COLOR TO VIM CONFIG
vim +PluginInstall +qall
youcompleteme_install=$HOME/.vim/bundle/YouCompleteMe/install.py
python $youcompleteme_install

# urxvt
sudo pacman -S rxvt-unicode
echo COPYING URXVT CONFIG FILE TO $HOME/.Xdefaults
cp -r $install_folder/urxvt/.Xdefaults $HOME/
mkdir -p $HOME/.urxvt/etx && cp $install_folder/urxvt/scripts/* $HOME/.urxvt/etx

# bash
echo SETTING UP BASHRC

cp $install_folder/bash/.bashrc $HOME/


