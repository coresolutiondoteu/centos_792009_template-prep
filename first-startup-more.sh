#!/bin/bash

#Reading all variables from /home/*.vars
read vm1_hostname_var < /home/flex-gw.vars
read vm2_hostname_var < /home/flex1.vars
read vm3_hostname_var < /home/flex2.vars
read vm4_hostname_var < /home/flex3.vars
read flexgwip_var < /home/flexgwip.vars
read flex1ip_var < /home/flex1ip.vars
read flex2ip_var < /home/flex2ip.vars
read flex3ip_var < /home/flex3ip.vars
read prefix_var < /home/prefix.vars
read netgwip_var < /home/netgwip.vars
read dnsip_var < /home/dnsip.vars

#Hosts file Update
#echo $flexgwip_var' flex-gw' >> /etc/hosts
#echo $flex1ip_var' flex1' >> /etc/hosts
#echo $flex2ip_var' flex2' >> /etc/hosts
#echo $flex3ip_var' flex3' >> /etc/hosts

#NTPd
systemctl start ntpd
systemctl enable ntpd
systemctl status ntpd

#Machine-ID
systemd-machine-id-setup
echo
cat /etc/machine-id
echo
#Shutdown the firewall
echo "Shutting down the firewall" 
systemctl disable firewalld
systemctl stop firewalld

echo

#Show current hostname
Current_Hostname=$(hostname)
echo
echo "Your hostname is $Current_Hostname"
echo
if [ "$Current_Hostname" = $vm1_hostname_var ] || [ "$Current_Hostname" = $vm2_hostname_var ] || [ "$Current_Hostname" = $vm3_hostname_var ] || [ "$Current_Hostname" = $vm4_hostname_var ]; then
    echo "Hostname is already set correctly..."
else
    echo "What VM Template clone number is this (1,2,3 or 4)?"
    read VMno_var
    if [ $VMno_var = 1 ]; then
        hostnamectl set-hostname $vm1_hostname_var
        NewHostName1=$(hostname)
        echo
        echo "Your new hostname is $NewHostName1"
        echo
	sed -i "s/BOOTPROTO=.*/BOOTPROTO="none"/" /etc/sysconfig/network-scripts/ifcfg-ens33
	echo
	echo "DHCP records from the VM were deleted, now we will set static definition."
	echo
	echo 'IPADDR='$flexgwip_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'PREFIX='$prefix_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'GATEWAY='$netgwip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'DNS1='$dnsip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
	#echo 'DNS2=8.8.8.8' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	#echo 'DNS3=8.8.4.4' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'DEFROUTE=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV4_FAILURE_FATAL=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV6INIT=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo $flexgwip_var' flex-gw' >> /etc/hosts
	echo $flex1ip_var' flex1' >> /etc/hosts
	echo $flex2ip_var' flex2' >> /etc/hosts
	echo $flex3ip_var' flex3' >> /etc/hosts
	echo
    else
        if [ $VMno_var = 2 ]; then
            	hostnamectl set-hostname $vm2_hostname_var
            	NewHostName2=$(hostname)
		echo
            	echo "Your new hostname is $NewHostName2"
            	echo
	    	sed -i "s/BOOTPROTO=.*/BOOTPROTO="none"/" /etc/sysconfig/network-scripts/ifcfg-ens33
		echo
		echo "DHCP records from the VM were deleted, now we will set static definition."
		echo
		echo 'IPADDR='$flex1ip_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
		echo 'PREFIX='$prefix_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
		echo 'GATEWAY='$netgwip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
		echo 'DNS1='$dnsip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
		#echo 'DNS2=8.8.8.8' >> /etc/sysconfig/network-scripts/ifcfg-ens33
		#echo 'DNS3=8.8.4.4' >> /etc/sysconfig/network-scripts/ifcfg-ens33
		echo 'DEFROUTE=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
		echo 'IPV4_FAILURE_FATAL=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
		echo 'IPV6INIT=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
		echo $flexgwip_var' flex-gw' >> /etc/hosts
		echo $flex1ip_var' flex1' >> /etc/hosts
		echo $flex2ip_var' flex2' >> /etc/hosts
		echo $flex3ip_var' flex3' >> /etc/hosts
		echo
        else
		if [ $VMno_var = 3 ]; then
			hostnamectl set-hostname $vm3_hostname_var
			NewHostName3=$(hostname)
                	echo
			echo "Your new hostname is $NewHostName3"
                	echo
			sed -i "s/BOOTPROTO=.*/BOOTPROTO="none"/" /etc/sysconfig/network-scripts/ifcfg-ens33
			echo
			echo "DHCP records from the VM were deleted, now we will set static definition."
			echo
			echo 'IPADDR='$flex2ip_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
			echo 'PREFIX='$prefix_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
			echo 'GATEWAY='$netgwip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
			echo 'DNS1='$dnsip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
			#echo 'DNS2=8.8.8.8' >> /etc/sysconfig/network-scripts/ifcfg-ens33
			#echo 'DNS3=8.8.4.4' >> /etc/sysconfig/network-scripts/ifcfg-ens33
			echo 'DEFROUTE=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
			echo 'IPV4_FAILURE_FATAL=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
			echo 'IPV6INIT=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
			echo $flexgwip_var' flex-gw' >> /etc/hosts
			echo $flex1ip_var' flex1' >> /etc/hosts
			echo $flex2ip_var' flex2' >> /etc/hosts
			echo $flex3ip_var' flex3' >> /etc/hosts
			echo
		else
                	if [ $VMno_var = 4 ]; then
                    		hostnamectl set-hostname $vm4_hostname_var
                    		NewHostName4=$(hostname)
                    		echo
                    		echo "Your new hostname is $NewHostName4"
				echo
				sed -i "s/BOOTPROTO=.*/BOOTPROTO="none"/" /etc/sysconfig/network-scripts/ifcfg-ens33
				echo
				echo "DHCP records from the VM were deleted, now we will set static definition."
				echo
				echo 'IPADDR='$flex3ip_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
				echo 'PREFIX='$prefix_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
				echo 'GATEWAY='$netgwip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
				echo 'DNS1='$dnsip_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
				#echo 'DNS2=8.8.8.8' >> /etc/sysconfig/network-scripts/ifcfg-ens33
				#echo 'DNS3=8.8.4.4' >> /etc/sysconfig/network-scripts/ifcfg-ens33
				echo 'DEFROUTE=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
				echo 'IPV4_FAILURE_FATAL=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
				echo 'IPV6INIT=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
				echo $flexgwip_var' flex-gw' >> /etc/hosts
				echo $flex1ip_var' flex1' >> /etc/hosts
				echo $flex2ip_var' flex2' >> /etc/hosts
				echo $flex3ip_var' flex3' >> /etc/hosts
				echo
                	else
                		echo
				echo "Only numbers in between 1 and up to 4 are allowed, but you did use $VMno_var which is illegal! Run this script again, please."
                    		echo
                	fi
            	fi
        fi
    fi
fi
echo
echo "Was hosts file updated? Can you see your IPs and hostnames?"
echo
echo
cat /etc/hosts
echo
echo
read -n 1 -r -s -p "Press any key to continue..."

sed -i '' -e '$ d' ~/.bash_profile
echo '/home/ssh-finish.sh' >> ~/.bash_profile

echo
rm -rf /.ssh/
ssh-keygen -q -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa

clear
echo
echo "/////////////////////////////////////////////////////////////////////"
echo "/                                                                   /" 
echo "/ Now I will reboot all your VMs and then finish the preparation.   /"
echo "/                                                                   /" 
echo "/ Please wait till the last cloned VM reboots, so you could login   /"
echo "/             with your newly set "STATIC" IP address.              /"
echo "/                                                                   /"
echo "/   If all cloned VMs booted up, login inside each VM with your     /"
echo "/                      favorite SSH client.                         /"
echo "/                                                                   /"
echo "/                Then press any key to continue.                    /"
echo "/                                                                   /"
echo "/////////////////////////////////////////////////////////////////////"
echo
echo
read -n 1 -r -s -p "Press any key to restart..."
reboot
