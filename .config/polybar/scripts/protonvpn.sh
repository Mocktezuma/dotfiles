#!/bin/sh

ip=$(sudo pvpn -ip)
vpn_status=$(pvpn --status | grep OpenVPN)


if [ "$vpn_status" = "[OpenVPN Status]: Not Running" ]; then
 
	echo "Vpn offline IP: $ip"
else
	echo "Vpn online  IP: $ip"
fi


