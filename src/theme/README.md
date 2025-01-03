# Scritps

Scripts to generate dotfiles:

- `generate`: generates all the dotfiles for a given theme
- `install`: installs all needed for a given theme
- `substitute`: uses `envsubst` and `jq` to substitute the values of a template for the values given on a json file.

## TODO

- [ ] Themes should be downloaded, and they should not be on the repo

### Templating

- [ ] config.sh: Some things should be configurable on config.sh file
- [ ] oh-my-zsh?: This is a cloned git repository, we should only have stored custom themes/plugins

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

- [ ] Polybar
- [ ] Zathura
- [ ] Spotify
