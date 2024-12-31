# Cottagecore

## Index

|                                                         |                                                 |
| ------------------------------------------------------- | ----------------------------------------------- |
| ![Example](docs/home_screen.png?raw=true "Homepage")    | ![Example](docs/rofi.png?raw=true "Rofi")       |
| ![Example](docs/qutebrowser.png?raw=true "Qutebrowser") | ![Example](docs/ranger_1.png?raw=true "Ranger") |
| ![Example](docs/ranger_2.png?raw=true "Ranger")         | ![Example](docs/spotify.png?raw=true "Spotify") |

---

## Dependencies

### Bare bones

| Name              | Description            |
| ----------------- | ---------------------- |
| **i3-wm/i3-gaps** | Tiling windows manager |
| **i3lock-color**  | Locked screen manager  |
| **xss-lock**      | Lock manager           |
| **polybar-git**   | Status bar manager     |
| **picom**         | Windows compositor     |

### Software

#### Essential applications

| Name          | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| **rofi**      | Window switcher, run dialog, ssh-launcher                    |
| **ranger**    | Text-based file manager                                      |
| **alacritty** | Terminal emulator                                            |
| **nitrogen**  | Desktop background browser and setter                        |
| **scrot**     | Screen shot software                                         |
| **pamixer**   | Command line mixer                                           |
| **caffeine**  | Prevents the screen from becoming idle while consuming media |

#### Programs

| Name            | Description        |
| --------------- | ------------------ |
| **neovim**      | Vim-like editor    |
| **qutebrowser** | Web browser        |
| **spotify**     | Audio streaming    |
| **spicetify**   | Spotify customizer |
| **zathura**     | PDF viewer         |
| **zsh**         | Shell              |

#### Other software and libraries

- nodejs
- npm
- yarn
- playerctl
- python3
  - dbus-python

### Fonts

- ttf-font-awesome
- awesome-terminal-fonts
- JetBrainsMono
- VictorMono
- Iosevska Nerd Font
- Noto Emoji Nerd Font

---

## Installing

> The bash script `install.sh` contains all the necessary steps to install this configuration on your device. It includes the following functions:

```
- instalar_dependencias
- eliminar_wallpapers
- copiar_dotfiles
- copiar_fuentes
- copiar_servicios
- instalar_caffeine
- configurar_nvim
- configurar_grub
- instalar_spotify
- config_spicetify
- config_spotify_adblock
```

- `instalar_dependencias`: install all the above mentioned programs on your computer.
- `eliminar_wallpapers`: deletes the previous wallpapers, if any, stored on `/home/.config/wallpapers`
- `copiar_dotfiles`: copies all the configurations for all the programs on your user home path. All of which are stored on `/home/.config`
- `copiar_fuentes`: copies all the above mentioned fonts on `/usr/share/fonts`.
- `copiar_servicios`: copies and enables all the services stored on `/services`
- `instalar_caffeine`: installs the package `caffeine-ng` and its dependencies.
  > When encountering this type of error:

```bash
python-xlib: /usr/lib/python3.9/site-packages/Xlib/xobject/resource.py
```

> You may execute:

```bash
$ sudo rm -r /usr/lib/python3.9/site-packages/Xlib/
```

> Beware of the danger this entails, if you intend to follow through, you will probably have to do this same operation on all the files that cause such error.

- `configurar_nvim`: configures neovim and installs all the plugins.
- `configurar_grub`: installs the grub theme
- `instalar_spotify`: installs Spotify on your device and opens the client in order to login in your spotify account (necessary to configure spicetify)
- `config_spicetify`: configures spiceitfy and sets the spotify theme
- `config_spotify_adblock`: installs the spotify plugin to prevent ads on spotify

> In the config file for `zsh` you must change your oh-my-zsh instalation:

```bash
export ZSH="/home/alba/.oh-my-zsh"
```

> Change it to your users path. This also applies for the wallpapers directory for nitrogen, in the default configuration (`~/.config/nitrogen/nitrogen.cfg`) it is set to:

```bash
dirs=/home/alba/.config/wallpapers
```

> Change it to `/home/$USER/.config/wallpapers`, where `$USER` is your username.
> It is possible that you are prompted to enter your sudo's password, when copying the fonts, for example.
> Also, you can comment the functions you have no use of (i.e. installing the dependencies), and also change where to copy the fonts.
> To install the configuration, simply execute:

```bash
$ ./install.sh
```

> Same goes to the services, which are enabled for the user `alba`. In case you want to change this, modify `install.sh` the line:

```bash
$ sudo systemctl enable suspend@alba
```

> To:

```bash
$ sudo systemctl enable suspend@$USER
```
