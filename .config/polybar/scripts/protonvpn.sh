#!/bin/sh
vpn_status=$(protonvpn s | grep Connected)


if [ "$vpn_status" = "Status:       Connected" ]; then
 
	echo "Vpn online"
else
	echo "Vpn offline"
fi


