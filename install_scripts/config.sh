#!/bin/bash

## If you run out of space on iso image:
## mount -o remount,size=1G /run/archiso/cowspace

############################################################################
## CONFIG
############################################################################

remove_slash() {
   echo "$@" | tr -s /
}

# Installation metadata

# Directory where all the scripts are
WORKDIR=$(remove_slash $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd))
# Directory where are the resources/dotfiles are
DIR_DOTFILES=$(remove_slash "$(dirname $WORKDIR)/dotfiles")
# Directory on the host where we copy the scripts and resources for later usage
INSTALL_FOLDER=$(remove_slash $(basename $WORKDIR))
# Install folder directory while on host machine
HOST_INSTALL_FOLDER=$(remove_slash "/$INSTALL_FOLDER")
HOST_DIR_DOTFILES=$(remove_slash "$HOST_INSTALL_FOLDER/dotfiles")
HOST_DIR_HOME=$(remove_slash "$HOST_DIR_DOTFILES/home")
HOST_DIR_FONTS=$(remove_slash "$HOST_DIR_DOTFILES/fonts")
HOST_DIR_ETC=$(remove_slash "$HOST_DIR_DOTFILES/etc")
HOST_DIR_SERVICES=$(remove_slash "$HOST_DIR_DOTFILES/services")
MACHINE_ARCH=$(uname -m)

# Installation modifiable information

INSTALLATION_DISK="/dev/sda"
BOOT_DIRECTORY="/boot"
# Change to 1 if you are installing on USB
USB=0

# System config

USER="alba"
LANG="es_ES.UTF-8"
CODEC="UTF-8"
KEYMAP="es"
TIMEZONE="Europe/Madrid"

# GRUB config

GRUB_PARTITION=$INSTALLATION_DISK
GRUB_CONF_DIR="$BOOT_DIRECTORY/grub/grub.cfg"
TARGET_GRUB_LEGACY="i386-pc"
TARGET_GRUB_EFI="x86_64-efi"
TARGET_GRUB_EFI_32="i386-efi"

# Image config

HOOKS_MKINITCPIO="(base udev block filesystems keyboard fsck)"

# Packages

TERMINAL="alacritty"

## Pacman
FIRMWARE="base base-devel linux linux-firmware networkmanager efibootmgr"
TWM="i3-gaps i3status"
XORG_PACKAGES="xorg-server xorg-apps xorg-xinit"
GPU_PACKAGES="xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau"
LIGHTDM_PACKAGES="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
BASIC_PACKAGES="$LIGHTDM_PACKAGES $GPU_PACKAGES $TWM $TERMINAL rofi imagemagick nitrogen zsh ranger gpicview scrot dunst git wget vim neovim nano"
UTILITIES_PACKAGES="xdg-utils acpi alsa-utils python-psutil"
PROGRAM_PACKAGES="qutebrowser zathura zathura-pdf-poppler"
DEVELOPMENT_SOFTWARE_PACKAGES="python-pip nodejs npm yarn"
NEOVIM_PACKAGES="python-neovim python-cpplint python-pynvim"

## Yay

AUR_PIPEWIRE="pipewire pipewire-pulse pipewire-jack pipewire-alsa pipewire-audio"
AUR_LOCKSCREEN="xss-lock i3lock-color"
# TODO ALBA: if on 32 bits do not install caffeine-ng libappindicator-gtk3 xss-lock i3lock-color foxitreader
AUR_SUSPEND_MGR="caffeine-ng libappindicator-gtk3"
AUR_BASIC_PACKAGES="picom-ftlabs-git pamixer pacman-contrib $AUR_PIPEWIRE $AUR_LOCKSCREEN $AUR_SUSPEND_MGR"
AUR_UTILITIES_PACKAGES="bluez bluez-utils"
AUR_PROGRAM_PACKAGES="foxitreader"
AUR_TERMINAL_CLI_PACKAGES="neofetch"
AUR_DEVELOPMENT_SOFTWARE_PACKAGES="llvm clang cmake texlive-most"
AUR_NEOVIM_PACKAGES="ripgrep tmux"
AUR_DEVELOPMENT_SOFTWARE_PACKAGES_32="llvm14"
