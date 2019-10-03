#!/bin/zsh

(sh -c "/usr/bin/nvidia-settings --load-config-only")&
echo "Loaded nvidia settings"

start-pulseaudio-x11&
echo "Started pulseaudio"



polybar top&
polybar bottom&

polybar top-ext&
polybar bottom-ext&
echo "Polybars launched..."

nitrogen --restore

echo "Wallpaper restored..."

compton&

echo "Compton launched..."

redshift&
echo "Started redshift"



