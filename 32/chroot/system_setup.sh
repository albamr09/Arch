#!/bin/bash

. ../utils.sh
. ../config.sh

# TODO: Move this to post-install
connect_network(){
    
    title_msg "Setting up network connection"

    nmcli device wifi
    nmcli --ask device wifi connect
}

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

    title_msg "Copying dotfiles for $USER"

    sudo cp -r $DIR_DOTFILES/.??* /home/$USER &> /dev/zero && log "Copying dotfiles for $USER"
    sudo chown -R $USER /home/$USER/.??* && sudo chmod -R 775 /home/$USER/.??* &> /dev/zero && log "Changing permissions for $USER"
    chmod 775 /home/$USER/.xsession &> /dev/zero && log "Changing xsession permission for $USER"

    title_msg "Copying dotfiles for root"
    sudo cp -r $DIR_DOTFILES/.??* /root &> /dev/zero && success_msg "Copying dotfiles for root" || error_msg "a"

    title_msg "Copying fonts"
    sudo cp -r $DIR_FONTS/* "/usr/share/fonts/" &> /dev/zero && log "Copying fonts"

    title_msg "Copying system configuration files"
    sudo cp -r $DIR_RESOURCES/etc/* /etc &> /dev/zero && log "Copying system config files"
}

install_neovim_plugins() {

    title_msg "Installing neovim plugins"

    nvim -c 'PlugInstall|q|q'
    nvim -c 'so ~/.config/nvim/init.vim|q'
    nvim -c 'PlugInstall|q|q|q'
}

# connect_network
# install_packages
# configure_packages
copy_dotfiles
# install_neovim_plugins