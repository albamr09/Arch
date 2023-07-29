#!/bin/bash

## If you run out of space on iso image:
## mount -o remount,size=1G /run/archiso/cowspace

############################################################################
## CONFIG
############################################################################

# Installation metadata

WORKDIR="$PWD"
INSTALL_FOLDER="$(basename $WORKDIR)"
MACHINE_ARCH=$(uname -m)
DIR_RESOURCES="$(dirname $WORKDIR)/dotfiles"

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
MINIMUM_PACKAGES="alsa-utils"