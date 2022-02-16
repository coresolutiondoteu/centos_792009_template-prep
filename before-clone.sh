#!/bin/bash
### !!! ### sudo chmod a+x /*.sh

#Commands for the cloning operation on newly installed CentOS 7.9.2009
#Credit: https://bitraboy.wordpress.com/2018/08/28/preparing-linux-template-vms/

#Stop logging services
service rsyslog stop 
service auditd stop

#Install required software
yum update --skip-broken -y
yum install -y nano

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
history -c 
sys-unconfig
