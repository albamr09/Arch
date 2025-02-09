#!/bin/bash

install_yay(){

    title_msg "Installing yay"
    execute sudo pacman -S --needed base-devel git --noconfirm

    execute cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
}