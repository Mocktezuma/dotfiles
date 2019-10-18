#!/bin/sh
source /home/adri/.cache/wal/colors.sh
ip=$(sudo pvpn -ip)
vpn_status=$(pvpn --status | grep OpenVPN)


if [ "$vpn_status" = "[OpenVPN Status]: Not Running" ]; then
 
	echo "\u001b[44;1m Vpn offline IP: $ip \u001b[0m"
else
	echo "%{B#f00}%{F#000}Vpn online  IP: $ip%{B- F-}"
fi


