#!/bin/sh
ip=$(protonvpn s | grep IP | awk '{$1=""; sub("^ ", ""); print $0;}')


echo " $ip "


