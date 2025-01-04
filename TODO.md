# TODO

- [ ] Restore support for 32bit on installation
- [ ] Get out of zsh terminal automatically
- [ ] Themes should be downloaded, and they should not be on the repo
- [ ] Add nesting levels to title and info messages?
- [ ] Add cleanup for theme installation
  - config
  - etc
  - grub
  - fonts
  - icons

### Templating

- [ ] config.sh: Some things should be configurable on config.sh file
- [ ] oh-my-zsh?: This is a cloned git repository, we should only have stored custom themes/plugins

Asegurarse que los plugins de zsh están ok

### Centralized Installing

Try to modularize installation:

- [ ] Basic installing: with basic services
- [ ] Advanced installing: other themes install additional modules

### Templates for common modules

There are some modules like zathura, polybar, etc. that are not present on every theme but are quite common. There should be a way to define common configurations that could optionally be added to themes based on some configuration file (like the `variables.json` file).

- [ ] Polybar
- [ ] Zathura
- [ ] Spotify

### Old

- Add an initial text showing things you might need to do before installing
  - Setup size of iso image
  - How to setup wifi
