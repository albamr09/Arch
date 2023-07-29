#!/bin/bash

# ANSI color codes
RED = '\033[91m'
GREEN = '\033[92m'
YELLOW = '\033[93m'
BLUE = '\033[94m'
RESET = '\033[0m'

function echo_with_color {
    local text=$1
    local color=$2
    echo -e "${color}${text}${RESET}"
}

title_msg() {
    echo_with_color "----------------------------------------------" $BLUE
    echo_with_color " + $1" $BLUE
    echo_with_color "----------------------------------------------" $BLUE
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