#!/bin/bash

. ../utils.sh
. ../config.sh

install_packages() {
    
    title_msg "Installing display server"
    sudo pacman -S $DISPLAY_PACKAGES --noconfirm

    title_msg "Installing display drivers"
    sudo pacman -S $DISPLAY_DRIVER_PACKAGES --noconfirm

    title_msg "Installing desktop environment packages"
    sudo pacman -S $DESKTOP_ENV_PACKAGES --noconfirm

    title_msg "Installing utilities packages"
    sudo pacman -S $UTILITIES_PACKAGES --noconfirm
    # Else pip does not work :/
    python3 -m ensurepip

    title_msg "Installing programs packages"
    sudo pacman -S $PROGRAM_PACKAGES --noconfirm

    install_yay
    title_msg "Installing AUR packages"
    yay -S $PACKAGES_AUR --answerdiff None --answerclean None

    title_msg "Installing oh-my-zsh"
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

configure_packages() {

    title_msg "Configuring i3-bar"
    pip3 install psutil && log "Configuring i3-bar"

    title_msg "Configuring ranger"
    ranger --copy-config=all && log "Configuring ranger"

    title_msg "Configuring tmux"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    configure_nvim
}

configure_nvim() {

    title_msg "Configuring neovim"

    title_msg "Configuring virtualenv"
    # Virtualenvs for python
    mkdir -p /home/$USER/.virtualenvs && cd /home/$USER/.virtualenvs
    python -m venv debugpy
    /home/$USER/.virtualenvs/debugpy/bin/pip3 install debugpy && cd /$INSTALL_FOLDER/chroot

    title_msg "Installing plugin manager"
    curl -fLo /home/$USER/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    pip3 install neovim cpplint pynvim
}

copy_dotfiles() {

    title_msg "Copying dotfiles for root"
    sudo cp -r $DIR_DOTFILES/.??* "/root" &&log "Copying dotfiles for root"

    title_msg "Copying fonts"
    sudo cp -r $DIR_FONTS/* "/usr/share/fonts/"

    title_msg "Copying system configuration files"
    sudo cp -r $DIR_RESOURCES/etc/* /etc

    title_msg "Copying dotfiles for $USER"

    sudo cp -r $DIR_DOTFILES/.??* /home/$USER &> /dev/zero && log "Copying dotfiles for $USER"
    sudo chown -R $USER /home/$USER/.??* && sudo chmod -R 775 /home/$USER/.??* &> /dev/zero && log "Changing permissions for $USER"
    chmod 775 /home/$USER/.xsession &> /dev/zero && log "Changing xsession permission for $USER"
}

install_neovim_plugins() {

    title_msg "Installing neovim plugins"
    nvim -c 'PlugInstall|q|q|q'
}

define_defaults(){

    title_msg "Define defaults"

    xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop && log "Changing default browser"
    chsh -s /bin/zsh && log "Changing default terminal interpreter"
}


## Execute steps
connect_network
install_packages
configure_packages
copy_dotfiles
install_neovim_plugins
define_defaults