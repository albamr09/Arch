#!/bin/bash

# suspend message display
pkill -u "$USER" -USR1 dunst

$HOME/.config/scripts/i3lock/blur/lock.sh

# resume message display
pkill -u "$USER" -USR2 dunst