#!/bin/bash

#Show current hostname
Current_Hostname=$(hostname)

#Hostnames
#Defined Hostnames:
VM1_Hostname_var="VM5_K3s-master"
VM2_Hostname_var="VM6_K3s-worker"
VM3_Hostname_var="VM7_K3s-worker"


#SSH key echange with other nodes
if [ "$Current_Hostname" = $VM1_Hostname_var ]; then
    ssh-copy-id -i ~/.ssh/id_rsa.pub $VM2_Hostname_var
    ssh-copy-id -i ~/.ssh/id_rsa.pub $VM3_Hostname_var

    echo "SSH keys were exchanged succesfully."
    echo
    echo "Please try to login without password to other hosts with 'ssh hostname' e.g. 'ssh $VM2_Hostname_var'"
    echo "(see sll options with 'cat /etc/hosts')"
else
    if [ "$Current_Hostname" = $VM2_Hostname_var ]; then
        ssh-copy-id -i ~/.ssh/id_rsa.pub $VM1_Hostname_var
	ssh-copy-id -i ~/.ssh/id_rsa.pub $VM3_Hostname_var
	echo "SSH keys were exchanged succesfully."
	echo
	echo "Please try to login without password to other hosts with 'ssh hostname' e.g. 'ssh $VM1_Hostname_var'"
	echo "(see sll options with 'cat /etc/hosts')"
    else
	echo
    fi
fi
echo
#Cleaning up startup scripts in ~/.bash_profile
sed -i '' -e '$ d' ~/.bash_profile
sed -i '' -e '$ d' ~/.bash_profile
echo "Environmental preparation is finished. You can proceed to next steps in your lab installation."
echo
echo "Thank you!"
echo