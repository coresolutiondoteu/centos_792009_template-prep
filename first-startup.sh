#!/bin/bash

#Machine-ID
systemd-machine-id-setup
echo
cat /etc/machine-id
echo
#Shutdown the firewall
echo "Shutting down the firewall" 
systemctl disable firewalld
systemctl stop firewalld

#Hostnames
#Defined Hostnames:
VM1_Hostname_var="flex-gw"
VM2_Hostname_var="flex1"
VM3_Hostname_var="flex2"
VM4_Hostname_var="flex3"

#Show current hostname
Current_Hostname=$(hostname)
echo
echo "Your hostname is $Current_Hostname"
echo
if [ "$Current_Hostname" = $VM1_Hostname_var ] || [ "$Current_Hostname" = $VM2_Hostname_var ] || [ "$Current_Hostname" = $VM3_Hostname_var ] || [ "$Current_Hostname" = $VM4_Hostname_var ]; then
        echo "Hostname is already set correctly"
        else
                echo "What VM number this is (1,2,3 or 4)?"
                read VMno_var
                if [ $VMno_var = 1 ]; then
                        hostnamectl set-hostname $VM1_Hostname_var
                                                NewHostName=$(hostname)
                                                echo
                                                echo "Your new hostname is $NewHostName"
                                                echo												
                else
                        if [ $VMno_var = 2 ]; then
                                hostnamectl set-hostname $VM2_Hostname_var
                                                                NewHostName=$(hostname)
                                                                echo
                                                                echo "Your new hostname is $NewHostName"
                                                                echo															
                        else
                                if [ $VMno_var = 3 ]; then
                                        hostnamectl set-hostname $VM3_Hostname_var
                                                                                NewHostName=$(hostname)
                                                                                echo
                                                                                echo "Your new hostname is $NewHostName"
                                                                                echo								
                                else
                                        if [ $VMno_var = 4 ]; then
                                                hostnamectl set-hostname $VM4_Hostname_var
                                                                                                NewHostName=$(hostname)
                                                                                                echo
                                                                                                echo "Your new hostname is $NewHostName"
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

#IP Addresses
#Removes DHCP from template
sed -i "s/BOOTPROTO=.*/BOOTPROTO="none"/" /etc/sysconfig/network-scripts/ifcfg-ens33
echo
echo "DHCP records from the VM were deleted, now we will set static definition."
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
echo "Please prepare your IP addresses, that we will use as static definition for your VMs."
echo
echo "What is your IP address for $NewHostName? Please type IP in format xxx.xxx.xxx.xxx"
read NewIP_var
echo
echo "What is your prefix for $NewHostName $NewIP_var? (e.g. for /16 write 16 for /24 write 24)"
read NewIP_prefix_var
echo
echo "What is your Gateway IP address for $NewHostName $NewIP_var/$NewIP_prefix_var? Please type IP in format xxx.xxx.xxx.xxx"
read NewIP_GW_var
echo
echo "What is your DNS address for $NewHostName? Please type IP in format xxx.xxx.xxx.xxx"
read NewIP_DNS_var
echo
#echo 'BOOTPROTO=none' >> /etc/sysconfig/network-scripts/ifcfg-ens33 //it is already inside default file
echo 'IPADDR='$NewIP_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
echo 'PREFIX='$NewIP_prefix_var >>/etc/sysconfig/network-scripts/ifcfg-ens33
echo 'GATEWAY='$NewIP_GW_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
echo 'DNS1='$NewIP_DNS_var >> /etc/sysconfig/network-scripts/ifcfg-ens33
#echo 'DNS2=8.8.8.8' >> /etc/sysconfig/network-scripts/ifcfg-ens33
#echo 'DNS3=8.8.4.4' >> /etc/sysconfig/network-scripts/ifcfg-ens33
echo 'DEFROUTE=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
echo 'IPV4_FAILURE_FATAL=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
echo 'IPV6INIT=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
#Now we need to restart the service to take effect or reboot the machine at the end of this script



#Hosts files
#We will copy from the first host using scp

if [ "$NewHostName" = $VM4_Hostname_var ]; then
    echo "What is your flex-gw host IP address? Type in format xxx.xxx.xxx.xxx"
		read GW_IP_var
		echo $GW_IP_var' flex-gw' >> /etc/hosts
	echo "What is your flex1 host IP address? Type in format xxx.xxx.xxx.xxx"
		read flex1_IP_var
		echo $flex1_IP_var' flex1' >> /etc/hosts
	echo "What is your flex2 host IP address? Type in format xxx.xxx.xxx.xxx"
		read flex2_IP_var
		echo $flex2_IP_var' flex2' >> /etc/hosts
	echo "What is your flex3 host IP address? Type in format xxx.xxx.xxx.xxx"
		read flex3_IP_var
		echo $flex3_IP_var' flex3' >> /etc/hosts
		echo
		echo "Your updated hosts file looks like this"
		echo
		cat /etc/hosts
		echo
		#SSH-keygen for flex3
		echo "Now I will create SSH key pairs and register flex3 to all other hosts for ssh access without password."
		echo
		echo "Login to each VM on request, with default root password choosen during the instalation."
		echo
		#Cleaning ~/.ssh/
		rm -rf /.ssh/
		ssh-keygen -q -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
		#Nodes SSH registration
		ssh-copy-id -i ~/.ssh/id_rsa.pub "$GW_IP_var"
		ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex1_IP_var"
		ssh-copy-id -i ~/.ssh/id_rsa.pub "$flex2_IP_var"
		#//Now we have to scp the hosts file across all hosts verify via ping if we can see each other over hostnames
		echo "Now I will copy 'hosts' file to other nodes, for proper name resolution without DNS."
		scp /etc/hosts root@"$GW_IP_var":/etc/hosts
		scp /etc/hosts root@"$flex1_IP_var":/etc/hosts
		scp /etc/hosts root@"$flex2_IP_var":/etc/hosts
		echo
		echo "Your system will reboot in 5 seconds."
		echo
		echo "Your environment preparation is finished, please run './ssh.sh' on flex-gw, flex1 and flex2 hosts (flex3 node preaparation is finished)."
		echo
		#Last line of .bash_profile deleted
		sed -i '' -e '$ d' ~/.bash_profile
		#Last line of .bash_profile deleted
		sed -i '' -e '$ d' ~/.bash_profile
		sleep 5 ; reboot		
else
	#Last line of .bash_profile deleted
	sed -i '' -e '$ d' ~/.bash_profile
fi
	
if [ "$NewHostName" = $VM4_Hostname_var ]; then
	echo
	echo "No need to run ssh-finish.sh on Flex3, skipping step..."
	sed -i '' -e '$ d' ~/.bash_profile
	echo
else
	echo '/home/ssh-finish.sh' >> ~/.bash_profile
	echo
	echo "Reboot your system once last VM runned the first automated script and rebooted, this step will finish your environment preparation."
	echo
	echo "Then you can proceed with the PowerFlex Installation."
	echo
	echo "Thank you!"
	echo
fi
