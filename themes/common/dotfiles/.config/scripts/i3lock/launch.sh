#!/bin/bash

# suspend message display
pkill -u "$USER" -USR1 dunst

${i3lock_theme}

# resume message display
pkill -u "$USER" -USR2 dunst
