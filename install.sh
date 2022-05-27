#!/bin/bash
# shell script to install packages necessary to set up an AP on RPI 4

echo "Updating the package list"
sudo apt-get update 
sleep 5s

echo "Installing hostapd package..."
sudo apt-get install -y hostapd 
sleep 5s

echo "Installing dns package..."
sudo apt-get install -y dnsmasq
sleep 5s

echo "Installing dhcp package..."
sudo apt-get install -y dhcpcd5
sleep 5s

echo "Stopping services..."
echo "Run the setup script to configure the AP..."
sudo systemctl unmask hostapd
sudo systemctl disable hostapd 
sudo systemctl disable dnsmasq

#echo "Enable the wireless AP services at boot..."
#sudo systemctl unmask hostapd
#sudo systemctl enable hostapd 
#sudo systemctl start hostapd 
#sleep 2s

#sudo systemctl enable dnsmasq
#sudo systemctl start dnsmasq
#sleep 2s
sleep 2
echo "All done!"

