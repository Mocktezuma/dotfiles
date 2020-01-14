#!/bin/bash

rofi_command="rofi -theme ~/.cache/wal/colors-rofi-dark-menu.rasi"

### Options ###
power_off="襤  "
reboot="  ﰇ"
lock="  "
suspend="鈴  "
log_out="  "
# Variable passed to rofi
options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $power_off)
     timew stop 'computer'
     sleep .5
	 systemctl poweroff
        ;;
    $reboot)
	 timew stop 'computer'
         sleep .5
         systemctl reboot
        ;;
    $lock)
        ~/myscripts/blurlock.sh
        ;;
    $suspend)
        ~/myscripts/blurlock.sh && systemctl suspend
        ;;
    $log_out)
        killall sublime_text
        sleep .5
        i3-msg exit
        ;;
esac


