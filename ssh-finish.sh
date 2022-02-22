#!/bin/bash

clear
echo "Please wait for each VM to finish boot and then continue."
echo
sleep 15
read -n 1 -r -s -p "All VMs booted? Press any key to continue..."

#Show current hostname
Current_Hostname=$(hostname)

#Defined Hostnames:
VM1_Hostname_var="flex-gw"
VM2_Hostname_var="flex1"
VM3_Hostname_var="flex2"
VM4_Hostname_var="flex3"

#SSH key echange with other nodes
if [ "$Current_Hostname" = $VM1_Hostname_var ]; then
    ssh-copy-id -i ~/.ssh/id_rsa.pub flex1
    ssh-copy-id -i ~/.ssh/id_rsa.pub flex2
    ssh-copy-id -i ~/.ssh/id_rsa.pub flex3
    echo "SSH keys were exchanged succesfully."
    echo
    echo "Please try to login without password to other hosts with 'ssh hostname' e.g. 'ssh flex1' (see sll options with 'cat /etc/hosts')."
else
    if [ "$Current_Hostname" = $VM2_Hostname_var ]; then
        ssh-copy-id -i ~/.ssh/id_rsa.pub flex-gw
		ssh-copy-id -i ~/.ssh/id_rsa.pub flex2
		ssh-copy-id -i ~/.ssh/id_rsa.pub flex3
		echo "SSH keys were exchanged succesfully."
		echo
		echo "Please try to login without password to other hosts with 'ssh hostname' e.g. ssh 'flex-gw' (see sll options with 'cat /etc/hosts')."
    else
        if [ "$Current_Hostname" = $VM3_Hostname_var ]; then
		    ssh-copy-id -i ~/.ssh/id_rsa.pub flex1
			ssh-copy-id -i ~/.ssh/id_rsa.pub flex-gw
			ssh-copy-id -i ~/.ssh/id_rsa.pub flex3
			echo "SSH keys were exchanged succesfully."
			echo
			echo "Please try to login without password to other hosts with 'ssh hostname' e.g. ssh 'flex-gw' (see sll options with 'cat /etc/hosts')."
        else
		    if [ "$Current_Hostname" = $VM4_Hostname_var ]; then
				ssh-copy-id -i ~/.ssh/id_rsa.pub flex1
				ssh-copy-id -i ~/.ssh/id_rsa.pub flex-gw
				ssh-copy-id -i ~/.ssh/id_rsa.pub flex2
				echo "SSH keys were exchanged succesfully."
				echo
				echo "Please try to login without password to other hosts with 'ssh hostname' e.g. ssh 'flex-gw' (see sll options with 'cat /etc/hosts')."
				echo
			else
				echo
			fi
        fi
    fi
fi
echo
#Cleaning up startup scripts in ~/.bash_profile
sed -i '' -e '$ d' ~/.bash_profile
sed -i '' -e '$ d' ~/.bash_profile
echo "Environmental preparation is finished. You can proceed with additional steps in your PowerFlex installation."
echo
echo "Thank you!"
echo
read -n 1 -r -s -p "Press any key to finish environment preparation."
echo "End of the script."
