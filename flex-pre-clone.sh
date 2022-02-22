#!/bin/bash

#Ideas
#
# echo "What is your future DNS IP/ NET GW IP address?"
# We could ask if it is the same like now and if yes, then use it?
#
# We could test the Ip ping and if there is correct answwer we could continue with the script?
# So we can be sure, that previous steps were done correctly.
#


##Setting up variables for later use
#Showing current IP configuration
clear
echo "Please make a snapshot on the VM and name it Fresh Install"
echo
read -n 1 -r -s -p "Done? Press any key to continue..."
clear
echo "---------------------------------------------------------------------------"
echo "Here is your default IP configuration from the DHCP in VMware Networking"
echo "By Default VMware Networking DHCP uses addresses x.x.x.128 - x.x.x.254"
echo "The best then would be to choose something like 192.168.xxx.3 till .127"
echo "Where for .xxx. you will use what VMware networking choosen for your VMNet"
echo "---------------------------------------------------------------------------"
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
echo "Please prepare your definied IP networking information:"
echo
echo "flex-gw IP >> Please choose new one e.g. 192.168.200.10"
echo "flex1 IP >> Please choose new one e.g. 192.168.200.11"
echo "flex2 IP >> Please choose new one e.g. 192.168.200.12"
echo "flex3 IP >> Please choose new one e.g. 192.168.200.13"
echo "Network PREFIX >> This maybe the same like it is now: 24"
echo "GATEWAY IP >> This maybe the same like it is now: "$Current_Gateway""
echo "DNS IP >> This maybe the same like it is now: "$Current_DNS""

#These are predefined variables for this installation
echo 'flex-gw' >> /home/flex-gw.vars
echo 'flex1' >> /home/flex1.vars
echo 'flex2' >> /home/flex2.vars
echo 'flex3' >> /home/flex3.vars
echo
echo "What is your future STATIC flex-gw IP address?"
read flexgwip_var
echo $flexgwip_var >> /home/flexgwip.vars
echo 
echo "What is your future STATIC flex1 IP address?"
read flex1ip_var
echo $flex1ip_var >> /home/flex1ip.vars
echo
echo "What is your future STATIC flex2 IP address?"
read flex2ip_var
echo $flex2ip_var >> /home/flex2ip.vars
echo
echo "What is your future STATIC flex3 IP address?"
read flex3ip_var
echo $flex3ip_var >> /home/flex3ip.vars
echo
echo "What is your future Network PREFIX? (e.g. for /16 write 16 and for /24 write 24)"
read prefix_var
echo $prefix_var >> /home/prefix.vars
echo
echo "What is your future Network GATEWAY IP address?"
# We could ask if it is the same like now and if yes, then use it?
read netgwip_var
echo $netgwip_var >> /home/netgwip.vars
echo
echo "What is your future Network DNS IP address?"
# We could ask if it is the same like now and if yes, then use it?
read dnsip_var
echo $dnsip_var >> /home/dnsip.vars
echo
echo "Thank you, we have set variables for flex nodes preparation."
echo
clear
echo "Your new variable file looks like this:"
#echo
#cat /home/variables.vars
echo
echo read -n 1 -r -s -p "All good? Press any key to continue..."
clear
echo "Next process will be automatic and at the end VM will shutdown"
echo
echo "Then you can make 4 clones from your newly prepared template VM"
echo
read -n 1 -r -s -p "I am ready to generalize your template, press any key to continue..."
 

##Pre-Clone script defionition
clear
#Stop logging services
service rsyslog stop 
service auditd stop

#Install required software
yum update --skip-broken -y
yum install -y nano wget ntpd

##Get (latest) Scripts 
#wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/main/first-startup.sh
#wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/main/ssh-finish.sh
#chmod +x /home/*.sh
#echo ' ' >> ~/.bash_profile
#echo '#InstallationPowerFlex' >> ~/.bash_profile
#echo '/home/first-startup.sh' >> ~/.bash_profile

#clear
#echo
#cat ~/.bash_profile
#echo

#Yum CleanUp
yum clean all

#Clear the logs
/usr/sbin/logrotate -f /etc/logrotate.conf
rm -f /var/log/*-???????? /var/log/*.gz
rm -f /var/log/dmesg.old
rm -rf /var/log/anaconda

#Truncate Audit Logs
/bin/cat /dev/null > /var/log/audit/audit.log 
/bin/cat /dev/null > /var/log/wtmp 
/bin/cat /dev/null > /var/log/lastlog 
/bin/cat /dev/null > /var/log/grubby

#Devices
rm -f /etc/udev/rules.d/70*
sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-ens33

#Temp
rm -rf /tmp/*
rm -rf /var/tmp/*

#SSH Keys
rm -f /etc/ssh/*key*

#Machine-id
rm -f /etc/machine-id

#History
rm -f ~root/.bash_history
unset HISTFILE

#Root User History:
rm -rf ~root/.ssh/
rm -f ~root/anaconda-ks.cfg

###Final Step (this will shutdown VM)
clear
echo
#echo "Now I will Turn Off the Template VM, and you can make 4 clones of this Template to continue with your PowerFlex installation."
echo
#echo "Turn them one by one, not at the same time, to overcome any IP issues or so."
echo "New text here is needed..."
#echo "First login inside the VM and then Turn ON another one. Wait for the 'first-startup.sh' to finish before moving to other steps."
echo
read -n 1 -r -s -p "Press any key to continue..."
echo "Shutting down!"
clear
echo
history -c 
sys-unconfig
