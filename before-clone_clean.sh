#!/bin/bash

#Commands for the cloning operation on newly installed CentOS 7.9.2009
#Credit: https://bitraboy.wordpress.com/2018/08/28/preparing-linux-template-vms/

#Stop logging services
service rsyslog stop 
service auditd stop

#Install required software
yum update --skip-broken -y
yum install -y nano
yum install -y wget

#Get (latest) Scripts 
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/different/first-startup_clean.sh
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/different/ssh-finish_clean.sh
chmod +x /home/*.sh
echo ' ' >> ~/.bash_profile
echo '#Installation_K8s' >> ~/.bash_profile
echo '/home/first-startup_clean.sh' >> ~/.bash_profile

pause 5
echo
cat ~/.bash_profile
echo
pause 5 

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
echo
echo "Now I will Turn Off the Template VM, and you can make 4 clones"
echo "of this Template to continue with your installation."
echo
echo "Turn them one by one, not at the same time," 
echo "to overcome any IP issues or so later."
echo
echo "First login inside the Cloned VM and wait till the end of the script,"
echo "then Turn ON next VM and Waittill end before moving to next steps."
echo
read -n 1 -r -s -p "Press any key to continue..."
echo "Shutting down!"
echo
history -c 
sys-unconfig
