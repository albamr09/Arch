#!/bin/bash

CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. utilities.sh
. ./common/utils.sh
. constants.sh

clean () {
    title_msg "Removing wallpapers ..."
    execute rm -rf $HOME/.config/wallpapers
}

install_packages() {

    #----
    title_msg "Installing yay ..."
    install_yay
    
    #----
    title_msg "Installing ..."
    execute yay -S $PKGS --answerdiff None --answerclean None --noconfirm

    title_msg "Installing oh-my-zsh"
    # Avoid entering zsh console
    export RUNZSH="no" && sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

configure_packages() {

    title_msg "Configuring tmux"
    execute rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    title_msg "Configuring zsh"
    execute git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    configure_nvim
}

configure_nvim() {

    title_msg "Configuring neovim"

    title_msg "Configuring virtualenv"
    # Virtualenvs for python
    execute mkdir -p /home/$USER/.virtualenvs && cd /home/$USER/.virtualenvs
    execute python -m venv debugpy
    execute /home/$USER/.virtualenvs/debugpy/bin/pip3 install debugpy && cd /$INSTALL_FOLDER/chroot

    title_msg "Installing plugin manager"
    execute curl -fLo /home/$USER/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    title_msg "Installing LSP dependencies"
    execute sudo npm install -g prettier

    title_msg "Installing tree-sitter dependencies"
    # Avoid tree sitter executable errors (only for latex)
    execute sudo npm install -g tree-sitter-cli
}

copy_dotfiles() {

    title_msg "Copying dotfiles for root"
    execute sudo cp -r "$DIR_DOTFILES/.??*" "/root"

    title_msg "Copying fonts"
    execute sudo cp -r "$DIR_FONTS/*" /usr/share/fonts/

    title_msg "Copying system configuration files"
    execute sudo cp -r "$DIR_ETC/*" /etc

    title_msg "Copying service configuration files"
    execute sudo cp -r "$DIR_SERVICES/*" /etc/systemd/system

    title_msg "Copying dotfiles for $USER"

    execute sudo cp -r --preserve=ownership "$DIR_DOTFILES/.??*" "/home/$USER"
    # Needed so telescope installs successfully, will be copied again after plugins are installed
    execute rm -rf "/home/$USER/.vim"
}

install_plugins() {

    title_msg "Installing neovim plugins"
    nvim --headless +PlugInstall +qall 2> /dev/null
    # Copy dotfiles for telescope that we removed earlier
    execute cp -rf -r $DIR_DOTFILES/.vim /home/$USER

    title_msg "Installing tmux plugins"
    execute ~/.tmux/plugins/tpm/bin/install_plugins
}

configure_services(){
    
    title_msg "Configuring services"

    execute sudo systemctl enable suspend@$USER
    execute sudo systemctl enable lightdm
    # Battery notifcation service
    execute systemctl --user enable check-battery-user.timer
    execute systemctl --user start check-battery-user.service
    execute sudo systemctl daemon-reload
}

define_defaults(){

    title_msg "Define defaults"

    execute xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
    execute chsh -s /bin/zsh
}

finish() {
    success_msg "Installation finished!"
    execute sudo rm -rf "$DIR_PROJECT"
}

## Execute steps
clean
install_packages
configure_packages
copy_dotfiles
install_plugins
configure_services
define_defaults

cd $SCRIPT_DIR
{{ (datasource "variables").install.inject.modules | default "" }}
cd $SCRIPT_DIR
{{ (datasource "variables").install.inject.custom | default "" }}

## Clean up

finish
