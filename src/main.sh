#!/bin/bash

# Entry point for installation program

# Directory of the currently running script
CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

info_msg "Will proceed with Arch Installation"

## Main installation
./core/install.sh

info_msg "Will proceed with Theme Installation"

## Theme installation
./theme/install.sh

cd $CURR_DIR