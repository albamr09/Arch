#!/bin/bash

## If you run out of space on iso image:
## mount -o remount,size=1G /run/archiso/cowspace

############################################################################
## CONFIG
############################################################################

# Installation modifiable information

INSTALLATION_DISK="/dev/sda"
BOOT_DIRECTORY="/boot"

# Packages

FIRMWARE="base base-devel linux linux-firmware networkmanager efibootmgr"