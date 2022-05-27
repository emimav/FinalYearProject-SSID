#!/bin/bash
# This script configures the SSID in /etc/hostapd/hostapd.conf 

if [ "$EUID" -ne 0 ];
then 
	echo "make sure to run this as root"
	exit
fi

if [ ! -f /etc/hostapd/hostapd.conf ]
then 
	echo "run sudo ./config-ap.sh to create file  /etc/hostapd/hostapd.conf"
	exit
else 
	ssid="\x02\x0C\x00\x00\x02"
	
	sed -i "s/\bssid\b=.*/ssid=$ssid/" /etc/hostapd/hostapd.conf
	sleep 2s
	echo "SSID changed to $ssid"
	sleep 2s
	echo "Restarting hostapd"
	systemctl restart hostapd
fi
