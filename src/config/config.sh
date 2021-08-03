
# -------------------------------------------------------------------------------------
# Installation modifiable information
# -------------------------------------------------------------------------------------

DISCO_INSTALACION="/dev/sda"

USUARIO="alba"
IDIOMA="es_ES.UTF-8"
CODIFICACION="UTF-8"
KEYMAP="es"
DISPOSITIVO_GRUB=$DISCO_INSTALACION
USB=1                                           # USB = 0, indica no instalacion usb
ZONA_HORARIA="Europe/Madrid"

DIRECTORIO_BOOT="/boot"

DRIVERS="xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau"

# -------------------------------------------------------------------------------------
# GRUB configuration
# -------------------------------------------------------------------------------------

HOOKS_MKINITCPIO="(base udev block filesystems keyboard fsck)"
TARGET_GRUB_LEGACY="i386-pc"
TARGET_GRUB_EFI="x86_64-efi"
DIRECTORIO_GRUB_CONF="/boot/grub/grub.cfg"

# -------------------------------------------------------------------------------------
# Download packages after install
# -------------------------------------------------------------------------------------

TERMINAL="alacritty"
TWM="i3-wm i3-gaps i3status"
PAQUETES="nitrogen vim git wget neovim python-pip zsh nano texlive-most xdg-utils qutebrowser zathura zathura-pdf-poppler ranger w3m cmus"
#thunar
PAQUETES_AUR="vscode;pamixer;pacman-contrib;ttf-font-awesome;foxitreader"
#surf;firefox;


# -------------------------------------------------------------------------------------
# Refresh mirrors
# -------------------------------------------------------------------------------------

KEYSERVER="hkp://keys.gnupg.net:80"
ARQUITECTURA="archlinux"

# -------------------------------------------------------------------------------------
# Wallpaper directory
# -------------------------------------------------------------------------------------

DIR_FONDOS="/home/$USUARIO/Wallpapers"
DIR_FONDOS_REG="\/home\/$USUARIO\/Wallpapers"


# -------------------------------------------------------------------------------------
# Dotfiles directory
# -------------------------------------------------------------------------------------

DIR_DOTFILES="../config-files/dotfiles"

# -------------------------------------------------------------------------------------
# Fonts directory
# -------------------------------------------------------------------------------------

DIR_FONTS="../config-files/fonts"
HOST_DIR_FONTS="/usr/share/fonts/"


# -------------------------------------------------------------------------------------
# User scripts directory
# -------------------------------------------------------------------------------------

DIR_USER_SCRIPTS="../utils/user"
COPY_DOTFILES="copy-dotfiles.sh"
PKG_MANAGER="pkg-manager.sh"
PKG_INSTALL="pkg-install.sh"
CHANGE_DEFAULTS="change-defaults.sh"