#!/bin/bash

# Entry point for installation program

# Directory of the currently running script
CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

## Main installation
./core/install.sh

## Theme installation

cd $CURR_DIR