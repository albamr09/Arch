#!/bin/bash

CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ../common/utils.sh
. ../common/config.sh
. ../common/fs.sh

THEMES=($(ls -d "$THEMES_DIR"/*/ | grep -v "/common/" | xargs -n 1 basename))

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
    THEME_FOLDER="$THEMES_DIR/$SELECTED_THEME"
    THEME_CONFIG_FOLDER="$THEMES_DIR/$SELECTED_THEME/theme"
}

generate_theme() {
    title_msg "Generating theme: $SELECTED_THEME"

    execute rm -rf "$TMP_OUTPUT_DIR"
    if [[ " ${THEMES[@]} " =~ " ${SELECTED_THEME} " ]]; then
        execute mkdir -p "$TMP_OUTPUT_DIR"
        ./generate.sh "$THEME_CONFIG_FOLDER" "$TMP_OUTPUT_DIR"
    else
        error_msg "'$SELECTED_THEME' is not a valid theme or it has been ignored."
    fi
}

copy_theme() {
    mount_fs
    execute mkdir -p "$THEME_INSTALL_FOLDER" &&  mkdir -p "$SRC_INSTALL_FOLDER"
    # Make sure user has permissions to execute the after install scripts
    execute 'arch-chroot /mnt /bin/bash -c "chown -R $USER:$USER $CHROOT_INSTALL_FOLDER"'
    execute cp -rf "$TMP_OUTPUT_DIR/*" "$THEME_INSTALL_FOLDER"
    execute cp -rf "$THEME_FOLDER/src/*" "$COMMON_SCRIPTS_DIR" "$SRC_INSTALL_FOLDER"
    umount_fs
}

install_dependencies
select_theme
generate_theme
copy_theme

cd $CURR_DIR