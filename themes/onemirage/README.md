# One Mirage

One Mirage Theme

## docs

|                                                   |                                                                   |
| ------------------------------------------------- | ----------------------------------------------------------------- |
| ![Example](docs/home.png?raw=true "Homepage")     | ![Example](docs/terminal.png?raw=true "Terminal and Qutebrowser") |
| ![Example](docs/rofi.png?raw=true "Rofi")         | ![Example](docs/zathura.png?raw=true "Ranger")                    |
| ![Example](docs/ranger.png?raw=true "Ranger")     | ![Example](docs/spotify.png?raw=true "Spotify")                   |
| ![Example](docs/lock_1.png?raw=true "Lockscreen") | ![Example](docs/lock.png?raw=true "Lockscreen")                   |

## Dependencies

### Bare bones

| Name              | Description            |
| ----------------- | ---------------------- |
| **i3-wm/i3-gaps** | Tiling windows manager |
| **i3lock-color**  | Locked screen manager  |
| **xss-lock**      | Lock manager           |
| **picom**         | Windows compositor     |

### Software

| Nombre          | Descripción                                     |
| --------------- | ----------------------------------------------- |
| **polybar**     | Gestor de barra de tareas                       |
| **nitrogen**    | Gestor de fondos de pantalla                    |
| **alacritty**   | Terminal emulator                               |
| **rofi**        | Window switcher, run dialog, ssh-launcher       |
| **neovim**      | Editor de texto                                 |
| **pamixer**     | Pulseaudio command line mixer                   |
| **ranger**      | Gestor de ficheros                              |
| **scrot**       | Herramienta de docshots                         |
| **zsh**         | Terminal                                        |
| **nodejs**      | Entorno back-end de JavaScript                  |
| **npm**         | Administrador de paquetes para nodejs           |
| **qutebrowser** | Buscador web                                    |
| **playerctl**   | Mpris media player                              |
| **python3**     |                                                 |
| **python-pip**  | Python module manager                           |
| **zathura**     | Lector de PDF en terminal                       |
| **yarn**        | Administrador de paquetes para nodejs           |
| **acpi**        | Client for battery, power, and thermal readings |
| **dunst**       | Notification daemon                             |

### Fonts

- InputMono
- Iosevka
- MaterialIconsOutlined
- Mononoki

## Installing

> The bash script `install.sh` contains all the necessary steps to install this configuration on your device. It includes the following functions:

```
- instalar_dependencias
- eliminar_wallpapers
- copiar_dotfiles
- copiar_fuentes
- copiar_iconos
- copiar_servicios
- instalar_caffeine
- configurar_nvim
- configurar_dunst
- instalar_spotify
- iniciar_spotify
- config_spicetify
- config_spotify_adblock
```

- `instalar_dependencias`: install all the above mentioned programs on your computer.
- `eliminar_wallpapers`: deletes the previous wallpapers, if any, stored on `/home/.config/wallpapers`
- `copiar_dotfiles`: copies all the configurations for all the programs on your user home path. All of which are stored on `/home/.config`
- `copiar_fuentes`: copies all the above mentioned fonts on `/usr/share/fonts`.
- `copiar_iconos`: copies all the icons on `./icons/` to `/usr/share/icons/`.
- `copiar_servicios`: copies and enables all the services stored on `/services`
- `instalar_caffeine`: installs the package `caffeine-ng` and its dependencies.
- `configurar_nvim`: configures nvim and all of the plugins.
- `configurar_dunst`: configures the notification manager dunst.
- `instalar_spotify`: installs spotify client and spicetify and sets the required permissions.
- `iniciar_spotify`: prompts the user to log in spotify.
- `config_spicetify`: sets the given spicetify theme.
- `config_spotify_adblock`: installs and configures the ad-blocker for spotify.

To install the configuration, simply execute:

```bash
$ ./install.sh
```

---

### Troubleshoot

When encountering this type of error:

```bash
python-xlib: /usr/lib/python3.9/site-packages/Xlib/xobject/resource.py
```

You may execute:

```bash
$ sudo rm -r /usr/lib/python3.9/site-packages/Xlib/
```

Beware of the danger this entails, if you intend to follow through, you will probably have to do this same operation on all the files that cause such error.

---

### Notes

#### **Zsh**

In the config file for `zsh` you must change your oh-my-zsh instalation:

```bash
export ZSH="/home/alba/.oh-my-zsh"
```

Change it to your users path.

#### **Nitrogen**

For the wallpapers directory for nitrogen, in the default configuration (`~/.config/nitrogen/nitrogen.cfg`) it is set to:

```bash
dirs=/home/alba/.config/wallpapers
```

Change it to `/home/$USER/.config/wallpapers`, where `$USER` is your username.
It is possible that you are prompted to enter your sudo's password, when copying the fonts, for example.
Also, you can comment the functions you have no use of (i.e. installing the dependencies), and also change where to copy the fonts.

#### **Services**

Same goes to the services, which are enabled for the user `alba`. In case you want to change this, modify `install.sh` the line:

```bash
$ sudo systemctl enable suspend@alba
```

To:

```bash
$ sudo systemctl enable suspend@$USER
```

Also, the battery service file: `home/.config/systemd/user/check-battery-user.service` is configured for the user `alba`:

```config
[Service]
ExecStart=/home/alba/.config/scripts/battery/check-battery.sh
```

So you have to change it to:

```config
[Service]
ExecStart=/home/$USER/.config/scripts/battery/check-battery.sh
```

or wherever your `check-battery.sh` is.

#### **Spicetify**

Also, in the config file for spicetify: `./config/spicetify/config-xpui-ini` we have:

```config
prefs_path              = /home/alba/.config/spotify/prefs
```

You may change it to your user.

#### **Qutebroser**

In order to set the dracula theme on `duckduckgo`, you have to save it by pasting this script in your browser console while browsing https://duckduckgo.com:

```js
var dracula = [
  "7=282a36",
  "8=f8f8f2",
  "9=50fa7b",
  "ae=t",
  "t=p",
  "s=m",
  "w=n",
  "m=l",
  "o=s",
  "j=282a36",
  "a=p",
  "aa=bd93f9",
  "u=-1",
  "x=f1fa8c",
  "y=44475a",
  "af=1",
  "ai=1",
  "f=1",
];
for (var i = 0; i < dracula.length; i++) document.cookie = dracula[i];
alert("Appearance settings have successfully been updated!");
location.reload();
```

And also on the search page, after searching something.
