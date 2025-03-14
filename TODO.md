# TODO

### Centralized Installing

- [ ] Themes should be downloaded, and they should not be on the repo

#### Fixes

- [ ] Update polybar theme on gruVbox
- [ ] Spotify (loading theme automatically without having to open spotify)
- [ ] There might be files that are merged because they have the same name (polybar and lock `launch.sh`)

To test:

- [x] Picom (animations not working)
- [x] Update nvim configuration
- [x] Automatically install tmux plugings
- [x] Make scripts executable, some are not:

### Templating

- [ ] config.sh: Some things should be configurable on config.sh file

#### Templates for common modules

There are some modules like zathura, polybar, etc. that are not present on every theme but are quite common. There should be a way to define common configurations that could optionally be added to themes based on some configuration file (like the `variables.json` file).

- [ ] Polybar
- [ ] Zathura
- [ ] Spotify

### Nice to Have

- [ ] Restore support for 32bit on installation
- [ ] Add nesting levels to title and info messages?
- [ ] Add cleanup for theme installation
  - config
  - etc
  - grub
  - fonts
  - icons

### Old

- Add an initial text showing things you might need to do before installing
  - Setup size of iso image
  - How to setup wifi
