#!/bin/bash

#Showing current IP configuration
echo 
echo "Please write down your IP default configuration based on the DHCP from VMware Networking (By Default DHCP uses addresses x.x.x.128 - x.x.x.254)"
echo
#Add static IP information, based on your IP requirments
Current_IP=$(ip add | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/24')
echo "Your current IP address is: $Current_IP"
echo
Current_Gateway=$(ip route show default | awk '/default/ {print $3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
echo "Your current default Gateway is: $Current_Gateway"
echo
Current_DNS=$(cat /etc/resolv.conf | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
echo "Your current DNS server is: $Current_DNS"
echo
echo "Now you can proceed to next step, if you wrote down your current IP settings."
echo
