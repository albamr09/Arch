#!/bin/bash

create_spotify_config(){

  title_msg "Creating dummy spotify configuration"

  execute mkdir -p ~/.config/spotify
  execute mkdir -p ~/.config/spicetify

  execute echo "app.last-update-time=0" > ~/.config/spotify/prefs
  execute mkdir -p ~/.config/spotify/Users/dummy-user-user
}

# TODO: this requires to open spotify first :(
# 1. Open spotify -> login
# 2. Execute spicetify backup apply && spicetify apply
configure_spicetify(){
	
  title_msg "Configuring spicetify"
  
  spicetify backup apply
  spicetify restore backup
  
  execute spicetify config extensions {{ (datasource "variables").modules.spotify.extensions | default "" }}
  execute spicetify config current_theme {{ (datasource "variables").modules.spotify.theme }} color_scheme {{ (datasource "variables").modules.spotify.color_scheme }}
  execute spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
  spicetify apply --no-restart
}

configure_spotify_adblock(){

  title_msg "Configuring spotify-adblock"
  
  execute yay -S make rust --answerdiff None --answerclean None --noconfirm
  execute git clone https://github.com/abba23/spotify-adblock.git
  execute cd spotify-adblock && make
  execute sudo make install
  execute cd ..
  execute sudo rm -r spotify-adblock
}

configure_spotify(){

  title_msg "Installing spotify"
  
  execute yay -S spotify spicetify-cli --answerdiff None --answerclean None --noconfirm
  execute sudo chmod a+wr /opt/spotify
  execute sudo chmod a+wr /opt/spotify/Apps -R

  create_spotify_config
  configure_spicetify
  configure_spotify_adblock
}

configure_spotify