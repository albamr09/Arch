# Scritps

Scripts to create common and diff files for dotfiles:

- `diff_files`: shows the resulting diff of a dotfile for all the themes.
- `remove_files`: removes all the files with the same name as the given one. Ignores the common directory.
- `substitute`: uses `envsubst` and `jq` to substitute the values of a template for the values given on a json file.

## TODO

### Templating

- [ ] config
  - [x] alacritty
  - [x] dunst
  - [x] i3
  - [x] neofetch
  - [x] nitrogen
  - [x] nvim
  - [x] picom
  - [ ] qutebrowser
  - [ ] scripts
  - [x] systemd
  - [x] tmux
  - [x] rofi
- [ ] oh-my-zsh
- [x] vim
- [x] .xprofile
- [x] .xsession
- [ ] .zshrc
- [x] services
- [ ] etc

### Centralized Installing

Try to modularize installation:

- [ ] Generic dependencies
- [ ] Applications
