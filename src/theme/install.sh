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

    execute sudo curl -o /usr/local/bin/gomplate -sSL https://github.com/hairyhenderson/gomplate/releases/download/v4.3.0/gomplate_linux-386
    execute sudo chmod 755 /usr/local/bin/gomplate
    execute gomplate -v
}

# TODO: download themes from other repos
select_theme(){
    title_msg "Available themes:"
    for theme in "${THEMES[@]}"; do
        info_msg "$theme"
    done

    read -p "Please select a theme: " SELECTED_THEME
    THEME_FOLDER="$THEMES_DIR/$SELECTED_THEME"
    THEME_CONFIG_FOLDER="$THEMES_DIR/$SELECTED_THEME/theme"
    THEME_SRC_FOLDER="$THEMES_DIR/$SELECTED_THEME/src"
}

generate_theme() {
    title_msg "Generating theme: $SELECTED_THEME"

    execute rm -rf "$TMP_THEME_OUTPUT_DIR"
    if [[ " ${THEMES[@]} " =~ " ${SELECTED_THEME} " ]]; then
        execute mkdir -p "$TMP_THEME_OUTPUT_DIR"
        ./generate.sh "$THEME_CONFIG_FOLDER" "$TMP_THEME_OUTPUT_DIR" "$TEMPLATE_THEME_DIR"
    else
        error_msg "'$SELECTED_THEME' is not a valid theme or it has been ignored."
    fi
}

generate_installation_scripts() {
    title_msg "Generating install scripts: $SELECTED_THEME"

    execute rm -rf "$TMP_SCRIPTS_OUTPUT_DIR"
    if [[ " ${THEMES[@]} " =~ " ${SELECTED_THEME} " ]]; then
        execute mkdir -p "$TMP_SCRIPTS_OUTPUT_DIR"
        ./generate.sh "$THEME_SRC_FOLDER" "$TMP_SCRIPTS_OUTPUT_DIR" "$TEMPLATE_SRC_DIR"
    else
        error_msg "'$SELECTED_THEME' is not a valid theme or it has been ignored."
    fi
}

copy_theme() {
    mount_fs
    execute mkdir -p "$THEME_INSTALL_FOLDER" && mkdir -p "$SRC_INSTALL_FOLDER"
    execute cp -rf --preserve=mode "$TMP_THEME_OUTPUT_DIR/*" "$THEME_INSTALL_FOLDER"
    execute cp -rf --preserve=mode "$TMP_SCRIPTS_OUTPUT_DIR/*" "$COMMON_SCRIPTS_DIR" "$SRC_INSTALL_FOLDER"
    # Make sure user has permissions to intall the theme (this has to be always after any modification on the install folder)
    execute 'arch-chroot /mnt /bin/bash -c "chown -R $USER:$USER $CHROOT_INSTALL_FOLDER"'
    execute rm -rf "$TMP_THEME_OUTPUT_DIR" "$TMP_SCRIPTS_OUTPUT_DIR"
    umount_fs
}

install_dependencies
select_theme
generate_theme
generate_installation_scripts
copy_theme

cd $CURR_DIR