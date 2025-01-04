#!/bin/bash

# Entry point for installation program

# Directory of the currently running script
CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ./common/config.sh
. ./common/utils.sh

title_msg "Will proceed with Arch Installation"

## Main installation
./core/install.sh

title_msg "Will proceed with Theme Generation"

## Theme installation
./theme/install.sh

success_msg "Installation finished!"
info_msg "Remember to execute the post-install scripts (on $CHROOT_INSTALL_FOLDER) after reboot!"

cd $CURR_DIR