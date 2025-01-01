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

execute() {

    local command="$@"
    info_msg "$command"

    eval "$command" && success_msg || error_msg
}

info_msg(){
    echo_with_color " -> $1" $YELLOW
}

error_msg(){
    echo_with_color " - Failure" $RED; exit
}

success_msg(){
    echo_with_color " + Success" $GREEN
}

install_yay(){

    title_msg "Installing yay"
    execute sudo pacman -S --needed base-devel git --noconfirm

    execute cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
}