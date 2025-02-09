#!/bin/bash

configure_typewritten(){

  title_msg "Configure typewritten"

  execute git clone https://github.com/reobin/typewritten.git ~/.oh-my-zsh/custom/themes/typewritten
  execute ln -s "~/.oh-my-zsh/custom/themes/typewritten/typewritten.zsh-theme" "~/.oh-my-zsh/custom/themes/typewritten.zsh-theme"
  execute ln -s "~/.oh-my-zsh/custom/themes/typewritten/async.zsh" "~/.oh-my-zsh/custom/themes/async"
}

configure_grub(){

  title_msg "Configure grub theme"

  DIR_GRUB=$(remove_slash "$DIR_THEME/grub")
  
  execute sudo mkdir -p /boot/grub/themes
  execute sudo cp -r "$DIR_GRUB/cottagecore" /boot/grub/themes
  execute sudo sed -i 's/GRUB_THEME=".*"/GRUB_THEME="\/boot\/grub\/themes\/cottagecore\/theme.txt"/' /etc/default/grub
  execute sudo sed -i 's/#GRUB_THEME=".*"/GRUB_THEME="\/boot\/grub\/themes\/cottagecore\/theme.txt"/' /etc/default/grub
  execute sudo grub-mkconfig -o /boot/grub/grub.cfg
}

configure_typewritten
configure_grub