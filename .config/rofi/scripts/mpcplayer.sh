#!/usr/bin/env bash
rofi_command="rofi -theme ~/.cache/wal/colors-rofi-dark-menu-mpc.rasi"

mpc_status="$(mpc | grep playing)" 
# Variable passed to rofi

backward="  "
forward="  "

if [ -n "$mpc_status" ]
then
    playPause="  "
else
    playPause="  "
fi
options="$backward\n$playPause\n$forward"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2 -p "Music")"
case $chosen in
    $backward)
        mpc cdprev
        ;;
    $playPause)
        mpc toggle
        ;;
    $forward)
        mpc next
        ;;
esac




