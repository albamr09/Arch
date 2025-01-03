#!/bin/bash

CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ../common/utils.sh
. ../common/config.sh

THEMES=("classic" "cottagecore" "gruVbox" "onemirage" "quantumquartz")

install_dependencies() {
    title_msg "Installing dependencies"

    execute pacman -S jq
}

select_theme(){
    title_msg "Available themes:"
    for theme in "${THEMES[@]}"; do
        info_msg "$theme"
    done

    read -p "Please select a theme: " SELECTED_THEME
}

generate_theme() {
    title_msg "Generating theme: $SELECTED_THEME"

    execute rm -rf "$TMP_OUTPUT_DIR"
    if [[ " ${THEMES[@]} " =~ " ${SELECTED_THEME} " ]]; then
        execute mkdir -p "$TMP_OUTPUT_DIR"
        ./generate.sh "$SELECTED_THEME" "$TMP_OUTPUT_DIR"
    else
        error_msg "'$SELECTED_THEME' is not a valid theme or it has been ignored."
    fi
}

install_dependencies
select_theme
generate_theme

cd $CURR_DIR