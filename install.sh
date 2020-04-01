#!/bin/bash

install_folder=$(dirname $(readlink -f $0)) 

sudo pacman -S python ipython python-virtualenv wget

# COPY XORG CONFIG FILE TO HOMEFOLDER
cp ${install_folder}/xorg/.xinitrc $HOME

####### Vim #######
function install_vim {
    # Youcompleteme needs cmake
    sudo pacman -S vim vim-runtime cmake --noconfirm
    echo COPYING VIM CONFIG TO $HOME/.vimrc
    cp $install_folder/vim/.vimrc $HOME/
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    pip install flake8
    echo COPYING OLD-HOPE COLOR TO VIM CONFIG
    cp -rf $install_folder/vim/autoload $HOME/.vim/
    cp -rf $install_folder/vim/colors $HOME/.vim/
    cp -rf $install_folder/vim/UltiSnips $HOME/.vim/

    vim +PluginInstall +qall
    youcompleteme_install=$HOME/.vim/bundle/youcompleteme/install.py
    # IF NOT C++ needed install with  python $youcompleteme_install
    python $youcompleteme_install --clang-completer
    cp $install_folder/vim/global_extra_conf.py $HOME/
}

# WINDOW MANAGER i3-wm
function install_i3wm {
    echo COPY i3 CONFIG TO HOME DIRECTORY
    cp $install_folder/i3wm/config $HOME/.config/i3/config
}

function install_xfce4 {

    # INTEL
    #sudo pacman -S xf86-video-intel mesa 
    # AMD
    #sudo pacman -S xf86-video-amdgpu mesa
    # NVIDIA
    #sudo pacman -S nvidia nvidia-utils

    sudo pacman -S xorg xorg-server xfce4 xfce4-goodies --noconfirm
    # If one wants displaymanager at login
    sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm
    sudo systemctl enable lightdm
    ############################################
}

###### RICE ######
function install_rice {
    echo RICE UP THE DESKTOP
    sudo pacman -S xorg --noconfirm
    sudo pacman -S feh imagemagick python-pip python-pywal --noconfirm
    mkdir -p $HOME/Pictures/Wallpaper
    cp $install_folder/rice/fsociety.jpg $HOME/Pictures/Wallpaper
    echo INSERT TO .xinitrc: wal -i ~/Pictures/fsociety.jpg --saturate 0.9 -q
    echo 

}

function sound {
    sudo pacman -S alsa-utils --noconfirm
    # NICE INTERFACE FOR CONTROL SOUND
    sudo pacman -S pavucontrol  --noconfirm

}

####### TERMINAL urxvt ######
function install_urxvt {
    sudo pacman -S rxvt-unicode --noconfirm
    echo COPYING URXVT CONFIG FILE TO $HOME/.Xdefaults
    cp -r $install_folder/urxvt/.Xdefaults $HOME/
    mkdir -p $HOME/.urxvt/etx && cp $install_folder/urxvt/scripts/* $HOME/.urxvt/etx
}

# bash
function install_bash_config {
    echo COPYING BASHRC CONFIG FILE
    cp $install_folder/bash/.bashrc $HOME/
}

######## PRIVACY #########
# VPN and macchanger
function install_privacy_tools {
    sudo pacman -S openresolv openvpn macchanger --noconfirm
    sudo cp ${install_folder}/openvpn/update-resolv-conf /etc/openvpn/
    echo ADD FOLLOWING IN OPENVPN client.conf
    echo script-security 2
    echo up /etc/openvpn/update-resolv-conf.sh
    echo down /etc/openvpn/update-resolv-conf.sh
    echo down-pre
}

function nvidia {
    sudo pacman -S nvidia --noconfirm
    systemctl enable nvidia-persistenced
}
install_vim
install_i3wm
install_sound
install_rice
install_urxvt
install_bash_config
#install_privacy_tools
