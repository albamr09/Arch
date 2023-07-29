#!/bin/bash

. ../utils.sh
. ../config.sh

connect_network(){
    
    title_msg "Setting up network connection"

    nmcli device wifi
    nmcli --ask device wifi connect
}

install_display_server() {
    
    title_msg "Installing display server"
    pacman -S xorg-server xorg-apps xorg-xinit --noconfirm
}

connect_network
# install_display_server