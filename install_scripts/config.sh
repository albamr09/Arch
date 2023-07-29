#!/bin/bash

## If you run out of space on iso image:
## mount -o remount,size=1G /run/archiso/cowspace

############################################################################
## CONFIG
############################################################################

# Installation metadata

# Directory where all the scripts are
WORKDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Directory where are the resources/dotfiles are
DIR_RESOURCES="$(dirname $WORKDIR)/dotfiles"
# Directory on the host where we copy the scripts and resources for later usage
INSTALL_FOLDER=$(basename $WORKDIR)
# Install folder directory while on host machine
HOST_INSTALL_FOLDER="/$INSTALL_FOLDER"
DIR_DOTFILES="$HOST_INSTALL_FOLDER/dotfiles/home"
DIR_FONTS="$HOST_INSTALL_FOLDER/dotfiles/fonts"
DIR_SERVICES="$HOST_INSTALL_FOLDER/dotfiles/services"
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

# Image config

HOOKS_MKINITCPIO="(base udev block filesystems keyboard fsck)"

# Packages

FIRMWARE="base base-devel linux linux-firmware networkmanager efibootmgr"
TWM="i3-gaps i3status"
TERMINAL="alacritty"
DISPLAY_PACKAGES="xorg-server xorg-apps xorg-xinit"
DISPLAY_DRIVER_PACKAGES="xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau"
DESKTOP_ENV_PACKAGES="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings $TWM feh picom rofi imagemagick nitrogen zsh xdg-utils ranger w3m cmus gpicview scrot acpi dunst cmus"
UTILITIES_PACKAGES="alsa-utils $TERMINAL git wget python-pip python-psutil python-neovim python-cpplint python-pynvim"
PROGRAM_PACKAGES="qutebrowser zathura zathura-pdf-poppler nodejs npm yarn vim neovim nano"
PACKAGES_AUR="pamixer pacman-contrib foxitreader xss-lock i3lock-color caffeine-ng libappindicator-gtk3 neofetch llvm clang cmake ripgrep lldb tmux pipewire pipewire-pulse pipewire-jack pipewire-alsa pipewire-audio bluez bluez-utils texlive-most"
PACKAGES_AUR_32="llvm14"