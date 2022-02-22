#!/bin/bash

#Reading all variables from variables.vars
value=`cat /home/variables.vars`
clear
echo "Your scritp variables are:"
echo
echo $value
echo
sleep 5

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

#Show current hostname
Current_Hostname=$(hostname)
echo
echo "Your hostname is $Current_Hostname"
echo
if [ "$Current_Hostname" = $vm1_hostname_var ] || [ "$Current_Hostname" = $vm2_hostname_var ] || [ "$Current_Hostname" = $vm3_hostname_var ] || [ "$Current_Hostname" = $vm4_hostname_var ]; then
    echo "Hostname is already set correctly"
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
	systemctl restart network
	echo $flexgwip_var' flex-gw' >> /etc/hosts
	echo $flex1ip_var' flex1' >> /etc/hosts
	echo $flex2ip_var' flex2' >> /etc/hosts
	echo $flex3ip_var' flex3' >> /etc/hosts
	clear
	echo "Now we will create SSH keys and register them to ther hosts..."
	echo
	echo "Please type 'yes' when asked and use the default installation root password"
	echo
	echo "Please wait until the last VM get here, then continue..."
	echo
	echo read -n 1 -r -s -p "VM4 just get here? Press any key to continue..."
	clear
	rm -rf /.ssh/
	ssh-keygen -q -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
	#Nodes SSH registration
	ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex1ip_var"
	ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex2ip_var"
	ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex3ip_var"
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
			systemctl restart network
			echo $flexgwip_var' flex-gw' >> /etc/hosts
			echo $flex1ip_var' flex1' >> /etc/hosts
			echo $flex2ip_var' flex2' >> /etc/hosts
			echo $flex3ip_var' flex3' >> /etc/hosts
			clear
			echo "Now we will create SSH keys and register them to ther hosts..."
			echo
			echo "Please type 'yes' when asked and use the default installation root password"
			echo
			echo "Please wait until the last VM get here, then continue..."
			echo
			echo read -n 1 -r -s -p "VM4 just get here? Press any key to continue..."
			clear
			rm -rf /.ssh/
			ssh-keygen -q -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
			#Nodes SSH registration
			ssh-copy-id -i ~/.ssh/id_rsa.pub "$flexgwip_var"
			ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex2ip_var"
			ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex3ip_var"
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
				systemctl restart network
				echo $flexgwip_var' flex-gw' >> /etc/hosts
				echo $flex1ip_var' flex1' >> /etc/hosts
				echo $flex2ip_var' flex2' >> /etc/hosts
				echo $flex3ip_var' flex3' >> /etc/hosts
				clear
				echo "Now we will create SSH keys and register them to ther hosts..."
				echo
				echo "Please type 'yes' when asked and use the default installation root password"
				echo
				echo "Please wait until the last VM get here, then continue..."
				echo
				echo read -n 1 -r -s -p "VM4 just get here? Press any key to continue..."
				clear
				rm -rf /.ssh/
				ssh-keygen -q -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
				#Nodes SSH registration
				ssh-copy-id -i ~/.ssh/id_rsa.pub "$flexgwip_var"
				ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex1ip_var"
				ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex3ip_var"
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
					systemctl restart network
					clear
					echo "Now we will create SSH keys and register them to ther hosts..."
					echo
					echo "Please type 'yes' when asked and use the default installation root password"
					echo
					echo "Please wait until the last VM get here, then continue..."
					echo
					echo read -n 1 -r -s -p "You can continue on rest of your VMs. Press any key to continue..."
					clear
					rm -rf /.ssh/
					ssh-keygen -q -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
					#Nodes SSH registration
					ssh-copy-id -i ~/.ssh/id_rsa.pub "$flexgwip_var"
					ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex1ip_var"
					ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex2ip_var"
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
echo "Your environment preparation is finished, once your last VM get to this point."
echo
echo "After all VMs do finish with this script, it is advised to reboot them."
echo
echo "Then you can proceed with the K8s choosen flavour installation."
echo
echo "Thank you!"
echo
#Last line of .bash_profile deleted
#sed -i '' -e '$ d' ~/.bash_profile
#Last line of .bash_profile deleted
#sed -i '' -e '$ d' ~/.bash_profile
#sleep 5 ; reboot
