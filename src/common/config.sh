#!/bin/bash

## If you run out of space on iso image:
## mount -o remount,size=1G /run/archiso/cowspace

############################################################################
## CONFIG
############################################################################

remove_slash() {
   echo "$@" | tr -s /
}

### INSTALLATION

# Installation metadata

# Directory where all the scripts are (this should be src)
WORKDIR=$(dirname $(remove_slash $(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)))
# Install folder directory while on chroot
CHROOT_INSTALL_FOLDER=/root/archinstall
# Install folder directory while on host machine
INSTALL_FOLDER=/mnt/$CHROOT_INSTALL_FOLDER
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

FIRMWARE="base base-devel linux linux-firmware networkmanager efibootmgr"

### THEMES
REPO_DIR=$(cd -- "$(dirname -- "$WORKDIR" )" &> /dev/null && pwd)
THEMES_DIR="$REPO_DIR"/themes
TEMPLATE_THEME_DIR="$THEMES_DIR/common"
TMP_OUTPUT_DIR=$REPO_DIR/tmp_theme