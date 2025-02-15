remove_slash() {
   echo "$@" | tr -s /
}

# Installation metadata

# Directory where all the scripts are
DIR_SRC=$(remove_slash $(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd))
DIR_PROJECT=$(dirname "$DIR_SRC")
# Directory where are the resources/dotfiles are
DIR_THEME=$(remove_slash "$(dirname "$DIR_SRC")/theme")
DIR_DOTFILES=$(remove_slash "$DIR_THEME/dotfiles")
DIR_FONTS=$(remove_slash "$DIR_THEME/fonts")
DIR_ETC=$(remove_slash "$DIR_THEME/etc")
DIR_SERVICES=$(remove_slash "$DIR_THEME/services")
MACHINE_ARCH=$(uname -m)

############
# PACKAGES

TERMINAL="alacritty"
TWM="i3-gaps"
BAR="{{ (datasource "variables").install.packages.bar }}"
XORG_PACKAGES="xorg-server xorg-apps xorg-xinit"
GPU_PACKAGES="xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau"
LIGHTDM_PACKAGES="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
PIPEWIRE="pipewire pipewire-pulse pipewire-alsa pipewire-audio"
LOCKSCREEN="xss-lock i3lock-color"
SUSPEND_MGR="caffeine-ng libappindicator-gtk3"
BASIC_PACKAGES="$LIGHTDM_PACKAGES $GPU_PACKAGES $TWM $BAR $TERMINAL $PIPEWIRE $LOCKSCREEN $SUSPEND_MGR \
   rofi imagemagick nitrogen zsh gpicview scrot dunst git wget vim neovim nano unzip picom-ftlabs-git pamixer pacman-contrib"
UTILITIES_PACKAGES="xdg-utils acpi alsa-utils python-psutil bluez bluez-utils bluetooth-autoconnect neofetch {{ (datasource "variables").install.packages.utilities | default "" }}"
PROGRAM_PACKAGES="qutebrowser zathura zathura-pdf-poppler okular"
DEVELOPMENT_SOFTWARE_PACKAGES="python-pip nodejs npm yarn llvm clang cmake texlive"
NEOVIM_PACKAGES="python-neovim python-cpplint python-pynvim ripgrep tmux lazygit"
PKGS="$XORG_PACKAGES $BASIC_PACKAGES $UTILITIES_PACKAGES $PROGRAM_PACKAGES $DEVELOPMENT_SOFTWARE_PACKAGES \
   $NEOVIM_PACKAGES"