#!/bin/bash

# Entry point for installation program

# Directory of the currently running script
CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ./common/utils.sh

title_msg "Will proceed with Arch Installation"

## Main installation
./core/install.sh

title_msg "Will proceed with Theme Installation"

## Theme installation
./theme/install.sh

title_msg "Installation finished! Remember to execute the post install scripts (on $CHROOT_INSTALL_FOLDER) after reboot!"

cd $CURR_DIR