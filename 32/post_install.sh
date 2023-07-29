#!/bin/bash

. utils.sh
. config.sh

connect_network(){
    
    title_msg "Setting up network connection"

    nmcli device wifi
    nmcli --ask device wifi connect
}

install_packages() {
    
    title_msg "Installing display server"
    pacman -S $DISPLAY_PACKAGES --noconfirm

    title_msg "Installing display drivers"
    pacman -S $DISPLAY_DRIVER_PACKAGES --noconfirm

    title_msg "Installing desktop environment packages"
    pacman -S $DESKTOP_ENV_PACKAGES --noconfirm

    title_msg "Installing utilities packages"
    pacman -S $UTILITIES_PACKAGES --noconfirm

    title_msg "Installing programs packages"
    pacman -S $PROGRAM_PACKAGES --noconfirm

    install_yay
    title_msg "Installing AUR packages"
    yay -S $PACKAGES_AUR --answerdiff None --answerclean None
}

connect_network
install_packages