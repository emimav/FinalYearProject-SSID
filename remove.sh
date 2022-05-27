#!/bin/bash

echo "Removing all software"
sudo rm -rf /etc/hostapd
sudo rm -f /etc/dnsmasq.conf

sudo apt-get remove --purge dnsmasq dhcpcd5 hostapd -yqq

sudo systemctl restart NetworkManager 
