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
# Directory on the host where we copy the scripts and resources for later usage
INSTALL_FOLDER=$(remove_slash $(basename $WORKDIR))
# Install folder directory while on host machine
HOST_INSTALL_FOLDER=$(remove_slash "/$INSTALL_FOLDER")
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

## 32 bit
## TODO ALBA: maybe these ones have to be removed? $AUR_LOCKSCREEN $AUR_SUSPEND_MGR
AUR_BASIC_PACKAGES_32="picom-ftlabs-git pamixer pacman-contrib $AUR_PIPEWIRE $AUR_LOCKSCREEN $AUR_SUSPEND_MGR"
AUR_DEVELOPMENT_SOFTWARE_PACKAGES_32="llvm14 clang cmake texlive-most"
AUR_PROGRAM_PACKAGES_32=""
