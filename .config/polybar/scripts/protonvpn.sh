#!/bin/sh
ip=$(sudo pvpn -ip)
vpn_status=$(pvpn --status | grep OpenVPN)


if [ "$vpn_status" = "[OpenVPN Status]: Not Running" ]; then
 
	echo "Vpn offline"
else
	echo "Vpn online"
fi


