#!/bin/bash

configure_spaceship_prompt(){
    
    title_msg "Configuring Spaceship Prompt"

    ZSH_CUSTOM="~/.oh-my-zsh/custom"
    execute git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    execute ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
}

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

configure_spaceship_prompt
copy_icons