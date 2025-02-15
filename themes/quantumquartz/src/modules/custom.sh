#!/bin/bash

configure_pi_zsh(){
    
    title_msg "Configuring Pi Zsh Prompt"

    ZSH_CUSTOM="~/.oh-my-zsh/custom"
    execute mkdir -p $ZSH_CUSTOM/themes
    execute wget -O $ZSH_CUSTOM/themes/pi.zsh-theme https://raw.githubusercontent.com/tobyjamesthomas/pi/master/pi.zsh-theme
}

configure_pi_zsh