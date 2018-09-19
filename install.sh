#!/bin/bash


install_folder=$(dirname $(readlink -f $0)) 

pacman_install=$install_folder/pacman


sudo pacman -S --needed - < $pacman_install/package_list.txt
# Vim stuff
echo COPYING VIM CONFIG TO $HOME/.vimrc
cp $install_folder/vim/.vimrc $HOME/
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
pip install flake8
echo COPYING OLD-HOPE COLOR TO VIM CONFIG
cp -r $install_folder/vim/autoload $HOME/.vim/
cp -r $install_folder/vim/colors $HOME./vim/
vim +PluginInstall +qall
youcompleteme_install=$HOME/.vim/bundle/YouCompleteMe/install.py
python $youcompleteme_install

# Openbox stuff
echo COPYING OPENBOX CONFIG FILE TO $HOME/.config
cp -r $install_folder/openbox $HOME/.config/

# urxvt
echo COPYING URXVT CONFIG FILE TO $HOME/.Xdefaults
cp -r $install_folder/urxvt/.Xdefaults $HOME/

# bash
cp $install_folder/bash/.bashrc $HOME/


# pypi packages
sudo pip install cookiecutter


# VPN
pacman -S openvn
cp ${install_folder}/openvpn/update-resolv-conf /etc/openvpn/
echo proceed to download .conf file for your VPN and add 
cat ${install_folder}/openvpn/install.sh 
