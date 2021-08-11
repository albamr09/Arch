#!/bin/sh

# i3 config in ~/.config/i3/config :
# bar {
#   status_command exec /home/alba/.config/i3status/mybar.sh
# }

bg_bar_color="#282828"
bg_vpn="#6D961B"
bg_shadow_vpn="#537213"
text_black="#000000"
bg_ip_local="#865DB7"
bg_shadow_ip_local="#65458B"
bg_sys_info="#ba3f31"
bg_shadow_sys_info="#923328"
bg_meteo="#CA7E0A"
bg_shadow_meteo="#A3660B"
bg_date="#2e82a5"
bg_shadow_date="#215F79"
bg_battery="#B76AA0"
bg_shadow_battery="#844C73"
bg_volume="#549583"
bg_shadow_volume="#3F6E61"

# Print a left caret separator
# @params {string} $1 text color, ex: "#FF0000"
# @params {string} $2 background color, ex: "#FF0000"
separator() {
  echo -n "{"
  echo -n "\"full_text\":\"\"," # CTRL+Ue0b2
  echo -n "\"separator\":false,"
  echo -n "\"separator_block_width\":0,"
  echo -n "\"border\":\"$bg_bar_color\","
  echo -n "\"border_left\":0,"
  echo -n "\"border_right\":0,"
  echo -n "\"border_top\":2,"
  echo -n "\"border_bottom\":3,"
  echo -n "\"color\":\"$1\","
  echo -n "\"background\":\"$2\""
  echo -n "}"
}

common() {
  echo -n "\"border\": \"$bg_bar_color\","
  echo -n "\"separator\":false,"
  echo -n "\"separator_block_width\":0,"
  echo -n "\"border_top\":2,"
  echo -n "\"border_bottom\":3,"
  echo -n "\"border_left\":0,"
  echo -n "\"border_right\":0"
}

# Sombra despues de cada seccion
# $1: Color de fondo
# $2: Color de fondo de seccion anterior

shadow() {
  separator $1 $2
  echo -n ",{"
  echo -n "\"name\":\"ip_public\","
	echo -n "\"full_text\":\" \","
  #echo -n "\"full_text\":\" $(/home/alba/.config/i3status/ip.py) \","
  echo -n "\"background\":\"$1\","
  common
  echo -n "},"
}

myvpn_on() {
  local icon=""
  if [ -d /proc/sys/net/ipv4/conf/proton0 ]; then
    icon=""
  fi

	shadow $3 $2
  separator $1 $3
  echo -n ",{"
  echo -n "\"name\":\"id_vpn\","      
  echo -n "\"full_text\":\"  ${icon} VPN   \","
	#echo -n "\"color\":\"$text_black\","
  echo -n "\"background\":\"$1\","
  common
  echo -n "},"
}

myip_local() {
	shadow $3 $2
  separator $1 $3
  echo -n ",{"
  echo -n "\"name\":\"ip_local\","
  echo -n "\"full_text\":\"    $(ip route get 1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')   \","
	#echo -n "\"color\":\"$text_black\","
  echo -n "\"background\":\"$1\","
  common
  echo -n "},"
}

sys_info() {
  
	#DISCO
	shadow $3 $2
  separator $1 $3
  echo -n ",{"
  echo -n "\"name\":\"id_disk_usage\","
  echo -n "\"full_text\":\"    $(/home/alba/.config/i3status/disk.py)%\","
  echo -n "\"background\":\"$1\","
	#echo -n "\"color\":\"#000000\","
  common
  echo -n "}"

	# RAM
	echo -n ",{"
 	echo -n "\"name\":\"id_memory\","
 	echo -n "\"full_text\":\"  $(/home/alba/.config/i3status/memory.py)%\","
 	echo -n "\"background\":\"$1\","
 	#echo -n "\"color\":\"#000000\","
	common
	echo -n "}"

	# CPU
  echo -n ",{"
  echo -n "\"name\":\"id_cpu_usage\","
  echo -n "\"full_text\":\"  $(/home/alba/.config/i3status/cpu.py)%   \","
  echo -n "\"background\":\"$1\","
	#echo -n "\"color\":\"#000000\","
  common
  echo -n "},"
}

meteo() {
	shadow $3 $2
  separator $1 $3
  echo -n ",{"
  echo -n "\"name\":\"id_meteo\","
  echo -n "\"full_text\":\"   $(/home/alba/.config/i3status/meteo.py)   \","
  echo -n "\"background\":\"$1\","
  common
  echo -n "},"
}

mydate() {
	shadow $3 $2
  separator $1 $3
  echo -n ",{"
  echo -n "\"name\":\"id_time\","
  echo -n "\"full_text\":\"    $(date "+%a %d/%m %H:%M")   \","
  #echo -n "\"color\":\"#000000\","
  echo -n "\"background\":\"$1\","
  common
  echo -n "},"
}

battery0() {
	shadow $3 $2
  separator $1 $3
  prct=$(cat /sys/class/power_supply/BAT0/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d'=' -f2)
  charging=$(cat /sys/class/power_supply/BAT0/uevent | grep "POWER_SUPPLY_STATUS" | cut -d'=' -f2)
  icon=""
  if [ "$charging" == "Charging" ]; then
    icon=""
  fi
  echo -n ",{"
  echo -n "\"name\":\"battery0\","
  echo -n "\"full_text\":\"   ${icon} ${prct}%   \","
  echo -n "\"background\":\"$1\","
  common
  echo -n "},"
}

volume() {
	shadow $3 $2
  separator $1 $3
  vol=$(awk '/%/ {gsub(/[\[\]]/,""); print $4}' <(amixer sget Master))
  echo -n ",{"
  echo -n "\"name\":\"id_volume\","
  if [ $vol -le 0 ]; then
    echo -n "\"full_text\":\"    ${vol}   \","
  else
    echo -n "\"full_text\":\"    ${vol}   \","
  fi
  echo -n "\"background\":\"$1\","
	#echo -n "\"color\":\"#000000\","
  common
  echo -n "},"
}

systemupdate() {
  separator $bg_bar_color $1
  local nb=$(checkupdates | wc -l)
  if (( $nb > 0)); then
    echo -n ",{"
    echo -n "\"name\":\"id_systemupdate\","
    echo -n "\"full_text\":\"    ${nb}   \""
    echo -n "}"
  fi
}

logout() {
  echo -n ",{"
  echo -n "\"name\":\"id_logout\","
  echo -n "\"full_text\":\"  \""
  echo -n "}"
}

echo '{ "version": 1, "click_events":true }'     # Send the header so that i3bar knows we want to use JSON:
echo '['                    # Begin the endless array.
echo '[]'                   # We send an empty first array of blocks to make the loop simpler:

# Now send blocks with information forever:
(while :;
do
	echo -n ",["
	myvpn_on $bg_vpn $bg_bar_color $bg_shadow_vpn
  myip_local $bg_ip_local $bg_vpn $bg_shadow_ip_local
  sys_info $bg_sys_info $bg_ip_local $bg_shadow_sys_info
  meteo $bg_meteo $bg_sys_info $bg_shadow_meteo
  mydate $bg_date $bg_meteo $bg_shadow_date
  battery0 $bg_battery $bg_date $bg_shadow_battery
  volume $bg_volume $bg_battery $bg_shadow_volume
  systemupdate $bg_volume
  logout
  echo "]"
	sleep 10
done) &

# click events
while read line;
do
  # echo $line > /home/alba/gitclones/github/i3/tmp.txt
  # {"name":"id_vpn","button":1,"modifiers":["Mod2"],"x":2982,"y":9,"relative_x":67,"relative_y":9,"width":95,"height":22}

  # VPN click
  if [[ $line == *"name"*"id_vpn"* ]]; then
    alacritty -e /home/alba/.config/i3status/click_vpn.sh &

  # CHECK UPDATES
  elif [[ $line == *"name"*"id_systemupdate"* ]]; then
    alacritty -e /home/alba/.config/i3status/click_checkupdates.sh &

  # CPU
  elif [[ $line == *"name"*"id_cpu_usage"* ]]; then
    alacritty -e htop &

  # TIME
  elif [[ $line == *"name"*"id_time"* ]]; then
    alacritty -e /home/alba/.config/i3status/click_time.sh &

  # METEO
  elif [[ $line == *"name"*"id_meteo"* ]]; then
    xdg-open https://openweathermap.org/city/2986140 > /dev/null &

  # CRYPTO
  #elif [[ $line == *"name"*"id_crypto"* ]]; then
  #  xdg-open https://www.livecoinwatch.com/ > /dev/null &

  # VOLUME
  elif [[ $line == *"name"*"id_volume"* ]]; then
    alacritty -e alsamixer &

  # LOGOUT
  elif [[ $line == *"name"*"id_logout"* ]]; then
    i3-nagbar -t warning -m 'Log out ?' -b 'yes' 'i3-msg exit' > /dev/null &

  fi  
done
