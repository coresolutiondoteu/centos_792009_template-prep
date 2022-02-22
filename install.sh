#!/bin/bash

clear

#Stop logging services
service rsyslog stop 
service auditd stop
echo
echo "Updating system may take some time, please wait..."
echo
#Install required software
yum update --skip-broken -y -q
yum install -y nano wget ntp -q

##Get (latest) Scripts
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/more/flex-pre-clone.sh
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/more/first-startup-more.sh
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/more/ssh-finish.sh
chmod +x /home/*.sh

clear
echo "///////////////////////////////////////////////////////////////////"
echo "/                                                                 /"
echo "/    System was updated and did install wget, nano and ntp.       /"
echo "/                                                                 /"
echo "/  Scripts were downloaded, please run '/home/flex-pre-clone.sh'  /"
echo "/                                       -----------------------   /"
echo "/ Praparation of your first template will begin with this script. /"
echo "/                                                                 /"
echo "/          I will guide you through the preparation.              /"
echo "/                                                                 /"
echo "///////////////////////////////////////////////////////////////////"
echo
