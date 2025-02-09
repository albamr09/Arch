#!/bin/bash

copy_icons(){
	
	title_msg "Copying icons"

	DIR_ICONS=$(remove_slash "$DIR_THEME/icons")

	for file in "$DIR_ICONS"/*.tar.gz; do
        [ -f "$file" ] || continue  # Skip if no .tar.gz files exist
        execute tar -xzf "$file" -C "$DIR_ICONS" && execute rm -f "$file"
    done

	execute sudo cp -rf --preserve=links "$DIR_ICONS/*" /usr/share/icons
    execute sudo gtk-update-icon-cache -q /usr/share/icons/Papirus
}

copy_icons