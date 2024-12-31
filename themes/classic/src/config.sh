remove_slash() {
   echo "$@" | tr -s /
}

# Installation metadata

# Directory where all the scripts are
WORKDIR=$(remove_slash $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd))
# Directory where are the resources/dotfiles are
DIR_DOTFILES=$(remove_slash "$(dirname $WORKDIR)/dotfiles")
DIR_HOME=$(remove_slash "$DIR_DOTFILES/home")
DIR_FONTS=$(remove_slash "$DIR_DOTFILES/fonts")
DIR_ETC=$(remove_slash "$DIR_DOTFILES/etc")
DIR_SERVICES=$(remove_slash "$DIR_DOTFILES/services")
MACHINE_ARCH=$(uname -m)


# Packages

TERMINAL="alacritty"

## Pacman
TWM="i3-gaps i3status"
XORG_PACKAGES="xorg-server xorg-apps xorg-xinit"
GPU_PACKAGES="xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau"
LIGHTDM_PACKAGES="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
BASIC_PACKAGES="$LIGHTDM_PACKAGES $GPU_PACKAGES $TWM $TERMINAL rofi imagemagick nitrogen zsh gpicview scrot dunst git wget vim neovim nano"
UTILITIES_PACKAGES="xdg-utils acpi alsa-utils python-psutil"
PROGRAM_PACKAGES="qutebrowser zathura zathura-pdf-poppler"
DEVELOPMENT_SOFTWARE_PACKAGES="python-pip nodejs npm yarn"
NEOVIM_PACKAGES="python-neovim python-cpplint python-pynvim"
PACMAN_PKGS="$XORG_PACKAGES $BASIC_PACKAGES $UTILITIES_PACKAGES $PROGRAM_PACKAGES $DEVELOPMENT_SOFTWARE_PACKAGES $NEOVIM_PACKAGES" 

## Yay

AUR_PIPEWIRE="pipewire pipewire-pulse pipewire-jack pipewire-alsa pipewire-audio"
AUR_LOCKSCREEN="xss-lock i3lock-color"
AUR_SUSPEND_MGR="caffeine-ng libappindicator-gtk3"
AUR_BASIC_PACKAGES="picom-ftlabs-git pamixer pacman-contrib $AUR_PIPEWIRE $AUR_LOCKSCREEN $AUR_SUSPEND_MGR"
AUR_UTILITIES_PACKAGES="bluez bluez-utils bluetooth-autoconnect"
AUR_PROGRAM_PACKAGES="foxitreader"
AUR_TERMINAL_CLI_PACKAGES="neofetch"
AUR_DEVELOPMENT_SOFTWARE_PACKAGES="llvm clang cmake texlive-most"
AUR_NEOVIM_PACKAGES="ripgrep tmux"
YAY_PKGS="$AUR_BASIC_PACKAGES $AUR_UTILITIES_PACKAGES $AUR_PROGRAM_PACKAGES $AUR_TERMINAL_CLI_PACKAGES $AUR_DEVELOPMENT_SOFTWARE_PACKAGES $AUR_NEOVIM_PACKAGES" 