#!/bin/bash
# This script configures an Raspberry Pi 4 as a Wireless AP
# Author: Emima Vaipan


if [ "$EUID" -ne 0 ];
then 
	echo "make sure to run this as root!"
	exit 	
fi
sleep 3s

clear

echo "configuring DHCP"
echo "interface wlan0
	static ip_address=192.168.4.1/24
	nohook wpa_supplicant" > /etc/dhcpcd.conf
sleep 3s	

echo "configuring dnsmasq"
echo "log-facility=/var/log/dnsmasq.log
	interface=wlan0
	dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h" > /etc/dnsmasq.conf


systemctl start dhcpcd
systemctl enable dhcpcd

echo "allow-hotplug wlan0

	iface wlan0 inet static
	address 192.168.4.1
	netmask 255.225.225.0" >> /etc/network/interfaces

echo "bring up the wifi interface and ensure it's unblocked"
ifconfig wlan0 up
rfkill unblock wlan
rfkill unblock wifi
sleep 3s

# 802.11i specs: 
# The length of the SSID information field is between 0 and 32 octets. 
# A 0 lenfth information filed i used within Probe Request management frames 
# to indicate the wildcard SSID. 



# if [ -f "/etc/hostapd/custom_ssid.txt" ];
#then
#	echo "customised SSID detected in /etc/hostapd/custom_ssid.txt"
#	ssid="echo /etc/hostapd/custom_ssid.txt"
#else
#	echo "default SSID used" 
#	ssid=MyLittlePony
#fi
#sleep 5s

echo "configuring hostapd"
sleep 5s

echo "country_code=GB

# Interface Settings
####################
interface=wlan0
# Use the nl80211 driver with the brcmfmac driver
driver=nl80211

# Wifi AP Settings
##################
# This is the name of the network 
ssid=MyLittlePonyy
# Use the 2.4GHz band
hw_mode=g
# Use channel 7
channel=7
# The network passphrase  
wpa_passphrase=Something

# Enable WMM (QoS) 
wmm_enabled=0

# Accept all MAC addresses 
macaddr_acl=0

# Encryption Settings
#####################
# Use WPA authentication
auth_algs=1
# Use WPA2
wpa=2
wpa_key_mgmt=WPA-PSK
# Use AES, instead of TKIP
wpa_pairwise=TKIP
rsn_pairwise=CCMP

# Require clients to know the network name
ignore_broadcast_ssid=0" >> /etc/hostapd/hostapd.conf
sleep 5s

echo "creating hostapd daemon" 
echo "DAEMON_CONF=/etc/hostapd/hostapd.conf" >> /etc/default/hostapd
sleep 5s

echo "setting google dns nameserver"
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sleep 5s


echo "restarting services to activate Access Point"
systemctl unmask hostapd 
systemctl enable hostapd 
systemctl enable dnsmasq
systemctl start dnsmasq
systemctl start hostapd
echo "configuration completed!"
echo "once host reboots, verify the new AP is available"
systemctl reboot

