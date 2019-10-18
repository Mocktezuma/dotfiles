#!/bin/bash

rofi_command="rofi -theme cff.rasi"

### Options ###
uni="  "
gare="  "
# Variable passed to rofi
options="$uni\n$gare"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $uni)
        ~/bin/homecff Charmettes | rofi -theme homecff.rasi -dmenu
        ;;
    $gare)
        ~/bin/homecff Fribourg | rofi -theme homecff.rasi -dmenu
        ;;
esac

