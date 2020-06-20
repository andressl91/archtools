#!/bin/bash

# Share Wifi with Eth device
#
#
# This script is created to work with Raspbian Stretch
# but it can be used with most of the distributions
# by making few changes. 
#
# Make sure you have already installed `dnsmasq`
# Please modify the variables according to your need
# Don't forget to change the name of network interface
# Check them with `ifconfig`

ip_address="192.168.20.8"
netmask="255.255.255.0"
dhcp_range_start="192.168.20.10"
dhcp_range_end="192.168.20.20"
dhcp_time="12h"
eth="eth0"
wlan="wlan0"

# Configure iptables to forward packet between interfaces
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t nat -A POSTROUTING -o $wlan -j MASQUERADE  
sudo iptables -A FORWARD -i $wlan -o $eth -m state --state RELATED,ESTABLISHED -j ACCEPT  
sudo iptables -A FORWARD -i $eth -o $wlan -j ACCEPT 
# Store rules to next boot: /etc/iptables/rules.v4
sudo iptables-save

# Enable ip_forwarding
sudo cp /etc/sysctl.conf /etc/sysctl.conf.backup
sudo sh -c "echo net.ipv4.ip_forward=1 > /etc/sysctl.conf"

# Update ip of interface handling DHCP later through dnsmasq
sudo ifconfig $eth $ip_address netmask $netmask

# Remove default route created by dhcpcd
sudo ip route del 0/0 dev $eth &> /dev/null

sudo systemctl stop dnsmasq

echo -e "interface=$eth\n\
bind-interfaces\n\
server=8.8.8.8\n\
domain-needed\n\
bogus-priv\n\
dhcp-range=$dhcp_range_start,$dhcp_range_end,$dhcp_time" > /etc/dnsmasq.conf


# Now enable  dnsmasq
sudo systemctl enable dnsmasq
