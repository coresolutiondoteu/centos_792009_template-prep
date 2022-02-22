#!/bin/bash

#Ideas
#
# echo "What is your future DNS IP/ NET GW IP address?"
# We could ask if it is the same like now and if yes, then use it?
#
# We could test the Ip ping and if there is correct answwer we could continue with the script?
# So we can be sure, that previous steps were done correctly.
#

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
echo "Now we can proceed to the next steps, I will need from you some imputs..."
echo
#These are predefined variables for this installation
echo vm1_hostname_var="flex-gw" >> /home/variables.vars
echo vm2_hostname_var="flex1" >> /home/variables.vars
echo vm3_hostname_var="flex2" >> /home/variables.vars
echo vm4_hostname_var="flex3" >> /home/variables.vars
echo
echo "What is your future flex-gw IP address?"
read flexgwip_var
echo 'flexgwip_var="'$flexgwip_var'"' >> /home/variables.vars
echo 
echo "What is your future flex1 IP address?"
read flex1ip_var
echo 'flex1ip_var="'$flex1ip_var'"' >> /home/variables.vars
echo
echo "What is your future flex2 IP address?"
read flex2ip_var
echo 'flex2ip_var="'$flex2ip_var'"' >> /home/variables.vars
echo
echo "What is your future flex3 IP address?"
read flex3ip_var
echo 'flex3ip_var="'$flex3ip_var'"' >> /home/variables.vars
echo
echo "What is your future network prefix? (e.g. for /16 write 16 for /24 write 24)"
read prefix_var
echo 'prefix_var="'$prefix_var'"' >> /home/variables.vars
echo
echo "What is your future network gateway IP address?"
# We could ask if it is the same like now and if yes, then use it?
read netgwip_var
echo 'netgwip_var="'$netgwip_var'"' >> /home/variables.vars
echo
echo "What is your future DNS IP address?"
# We could ask if it is the same like now and if yes, then use it?
read dnsip_var
echo 'dnsip_var="'$dnsip_var'"' >> /home/variables.vars
echo
echo "Thank you, we have set variables for flex nodes preparation."
echo
