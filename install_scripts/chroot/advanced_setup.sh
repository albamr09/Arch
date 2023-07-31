#!/bin/bash

. ../utils.sh
. ../config.sh

install_packages() {
    
    title_msg "Installing XORG"
    execute sudo pacman -S $XORG_PACKAGES --noconfirm

    title_msg "Installing basic packages"
    execute sudo pacman -S $BASIC_PACKAGES --noconfirm
    install_yay
    execute yay -S $AUR_BASIC_PACKAGES --answerdiff None --answerclean None --noconfirm

    title_msg "Installing utilities"
    execute sudo pacman -S $UTILITIES_PACKAGES --noconfirm
    execute yay -S $AUR_UTILITIES_PACKAGES --answerdiff None --answerclean None --noconfirm
    # Else pip does not work :/
    python3 -m ensurepip

    title_msg "Installing programs"
    execute sudo pacman -S $PROGRAM_PACKAGES --noconfirm
    execute yay -S $AUR_PROGRAM_PACKAGES --answerdiff None --answerclean None --noconfirm
    execute yay -S $AUR_TERMINAL_CLI_PACKAGES --answerdiff None --answerclean None --noconfirm

    title_msg "Installing programs for development"
    execute sudo pacman -S $DEVELOPMENT_SOFTWARE_PACKAGES --noconfirm
    execute yay -S $AUR_DEVELOPMENT_SOFTWARE_PACKAGES --answerdiff None --answerclean None --noconfirm

    title_msg "Installing programs for neovim"
    execute sudo pacman -S $NEOVIM_PACKAGES --noconfirm
    execute yay -S $AUR_NEOVIM_PACKAGES --answerdiff None --answerclean None --noconfirm


    if is_machine_32; then
        title_msg "Installing AUR packages for 32 bit version"
        execute yay -S $AUR_DEVELOPMENT_SOFTWARE_PACKAGES_32 --answerdiff None --answerclean None
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
    execute sudo cp -r $HOST_DIR_HOME/.??* "/root"

    title_msg "Copying fonts"
    execute sudo cp -r $HOST_DIR_FONTS/* "/usr/share/fonts/"

    title_msg "Copying system configuration files"
    execute sudo cp -r $HOST_DIR_ETC/* /etc

    title_msg "Copying service configuration files"
    execute sudo cp $HOST_DIR_SERVICES/* /etc/systemd/system

    title_msg "Copying dotfiles for $USER"

    execute sudo cp -r $HOST_DIR_HOME/.??* /home/$USER
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
    execute cp -rf -r $HOST_DIR_HOME/.vim /home/$USER
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
