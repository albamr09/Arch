#!/bin/bash

# suspend message display
pkill -u "$USER" -USR1 dunst

{{ (datasource "variables").i3lock.theme }}

# resume message display
pkill -u "$USER" -USR2 dunst
