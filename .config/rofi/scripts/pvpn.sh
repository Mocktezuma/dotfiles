#!/bin/bash

rofi_command="rofi -theme ~/.cache/wal/colors-rofi-dark-menu-alternate.rasi"

### Options ###
fast_connect="  "
random_connect="  "
p2p_connect="  "
disconnect="  "
# Variable passed to rofi
options="$fast_connect\n$random_connect\n$p2p_connect\n$disconnect"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $fast_connect)
     sudo pvpn -d && sudo pvpn -f
        ;;
    $random_connect)
         sudo pvpn -d && sudo pvpn -r
        ;;
    $p2p_connect)
        sudo pvpn -d && sudo pvpn -p2p
        ;;
    $disconnect)
        sudo pvpn -d
        ;;
esac


