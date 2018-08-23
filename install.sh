#!/bin/bash

echo "Hello"
echo "$(dirname $(readlink -f $0)) "
install_folder=$(dirname $(readlink -f $0)) 

pacman_install=$install_folder/pacman


pacman -S --needed - < $pacman_install/package_list.txt
# Vim stuff
cp $install_folder/vim/.vimrc $HOME/
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
pip install flake8
vim +PluginInstall +qall
youcompleteme_install=$HOME/.vim/bundle/YouCompleteMe/setup.py
python $youcompleteme_install

cp -r $install_folder/vim/autoload $HOME/.vim/
cp -r $install_folder/vim/colors $HOME./vim/


# Openbox stuff
cp -r $install_folder/openbox $HOME/.config/

# urxvt
cp -r $install_folder/urxvt/.Xdefaults $HOME/


echo $install_folder

echo "${HOME}"
