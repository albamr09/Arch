# Scritps

Scripts to create common and diff files for dotfiles:

- `diff_files`: shows the resulting diff of a dotfile for all the themes.
- `remove_files`: removes all the files with the same name as the given one. Ignores the common directory.
- `substitute`: uses `envsubst` and `jq` to substitute the values of a template for the values given on a json file.

## TODO

### Templating

- [x] config
  - [x] alacritty
  - [x] dunst
  - [x] i3
  - [x] neofetch
  - [x] nitrogen
  - [x] nvim
  - [x] picom
  - [x] qutebrowser
  - [x] scripts
  - [x] systemd
  - [x] tmux
  - [x] rofi
- [ ] oh-my-zsh
- [x] vim
- [x] .xprofile
- [x] .xsession
- [x] .zshrc
- [x] services
- [ ] etc

Asegurarse que los plugins de zsh están ok

### Centralized Installing

Try to modularize installation:

- [ ] Generic dependencies
- [ ] Applications

### Uniform Folder Structure

Make sure all folder follow the same structure as the common folder.

- [ ] Default

### Templates for common modules

There are some modules like zathura, polybar, etc. that are not present on every theme but are quite common. There should be a way to define common configurations that could optionally be added to themes based on some configuration file (like the `variables.json` file).
