#!/bin/bash

#Show current hostname
Current_Hostname=$(hostname)

#Hostnames
#Defined Hostnames:
VM1_Hostname_var="vm5_k3s-master"
VM2_Hostname_var="vm6_k3s-worker"
VM3_Hostname_var="vm7_k3s-worker"


#SSH key echange with other nodes
if [ "$Current_Hostname" = $VM1_Hostname_var ]; then
    ssh-copy-id -i ~/.ssh/id_rsa.pub $VM2_Hostname_var
    ssh-copy-id -i ~/.ssh/id_rsa.pub $VM3_Hostname_var
    echo "SSH keys were exchanged succesfully."
    echo
    echo "Please try to login without password to other hosts with 'ssh hostname' e.g. 'ssh $VM2_Hostname_var'"
    echo "(see sll options with 'cat /etc/hosts')"
    sed -i '' -e '$ d' ~/.bash_profile
    sed -i '' -e '$ d' ~/.bash_profile
    echo "Environmental preparation almost finished. Restart last VM7..."
else
    if [ "$Current_Hostname" = $VM2_Hostname_var ]; then
        ssh-copy-id -i ~/.ssh/id_rsa.pub $VM1_Hostname_var
	ssh-copy-id -i ~/.ssh/id_rsa.pub $VM3_Hostname_var
	echo "SSH keys were exchanged succesfully."
	echo
	echo "Please try to login without password to other hosts with 'ssh hostname' e.g. 'ssh $VM1_Hostname_var'"
	echo "(see sll options with 'cat /etc/hosts')"
	sed -i '' -e '$ d' ~/.bash_profile
        sed -i '' -e '$ d' ~/.bash_profile
        Echo "Environmental preparation is finished. You can proceed to next steps in your lab installation."
	echo
    else
    	echo
    fi
fi
echo
echo
echo "Thank you!"
echo
