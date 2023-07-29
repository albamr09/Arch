#!/bin/bash

. ../utils.sh
. ../config.sh

install_packages() {
    
    title_msg "Installing display server"
    execute sudo pacman -S $DISPLAY_PACKAGES --noconfirm

    title_msg "Installing display drivers"
    execute sudo pacman -S $DISPLAY_DRIVER_PACKAGES --noconfirm

    title_msg "Installing desktop environment packages"
    execute sudo pacman -S $DESKTOP_ENV_PACKAGES --noconfirm

    title_msg "Installing utilities packages"
    execute sudo pacman -S $UTILITIES_PACKAGES --noconfirm
    # Else pip does not work :/
    python3 -m ensurepip

    title_msg "Installing programs packages"
    execute sudo pacman -S $PROGRAM_PACKAGES --noconfirm

    install_yay
    title_msg "Installing AUR packages"
    execute yay -S $PACKAGES_AUR --answerdiff None --answerclean None

    if is_machine_32; then
        title_msg "Installing AUR packages for 32 bit version"
        execute yay -S $PACKAGES_AUR_32 --answerdiff None --answerclean None
    fi

    title_msg "Installing oh-my-zsh"
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

configure_packages() {

    title_msg "Configuring ranger"
    execute ranger --copy-config=all

    title_msg "Configuring tmux"
    execute git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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
}

copy_dotfiles() {

    title_msg "Copying dotfiles for root"
    execute sudo cp -r $DIR_DOTFILES/.??* "/root"

    title_msg "Copying fonts"
    execute sudo cp -r $DIR_FONTS/* "/usr/share/fonts/"

    title_msg "Copying system configuration files"
    execute sudo cp -r $DIR_RESOURCES/etc/* /etc

    title_msg "Copying dotfiles for $USER"

    execute sudo cp -r $DIR_DOTFILES/.??* /home/$USER
    execute sudo chown -R $USER /home/$USER/.??* && sudo chmod -R 775 /home/$USER/.??*
    execute chmod 775 /home/$USER/.xsession
    # Needed so telescope installs successfully, will be copied again after plugins are installed
    execute rm -rf /home/$USER/.vim
}

install_neovim_plugins() {

    title_msg "Installing neovim plugins"
    # TODO: add command so errors are not shown
    nvim -c 'PlugInstall'
    # Copy dotfiles for telescope that we removed earlier
    execute cp -rf -r $DIR_DOTFILES/.vim /home/$USER
}

define_defaults(){

    title_msg "Define defaults"

    execute xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
    execute chsh -s /bin/zsh
}


## Execute steps
install_packages
configure_packages
copy_dotfiles
install_neovim_plugins
define_defaults
