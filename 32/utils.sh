#!/bin/bash

# ANSI color codes
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
RESET='\033[0m'

function echo_with_color {
    local text=$1
    local color=$2
    local style=$3

    local format=""
    if [ "$style" = "bold" ]; then
        format="${BOLD}"
    fi

    echo -e "${format}${color}${text}${RESET}"
}

title_msg() {
    echo_with_color "----------------------------------------------" $CYAN bold
    echo_with_color " ==> $1" $CYAN bold
    echo_with_color "----------------------------------------------" $CYAN bold
}

log() {
    success_msg "Success on $1" || error_msg "Failure on $2"
}

error_msg(){
    echo_with_color " - $1" $RED; exit
}

success_msg(){
    echo_with_color " + $1" $GREEN
}

is_machine_32() {
    if [ "$MACHINE_ARCH" = "i686" ]; then
        return 0
    else
        return 1
    fi
}

update_pacman_keys() {
    if is_machine_32; then
        pacman -S archlinux32-keyring --noconfirm
    else
        pacman -S archlinux-keyring --noconfirm
    fi
}