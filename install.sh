#!/bin/bash

clear

##Get (latest) Scripts 
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/more/flex-pre-clone.sh
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/more/first-startup-more.sh
wget -P /home/ https://raw.githubusercontent.com/coresolutiondoteu/centos_792009_template-prep/more/ssh-finish.sh
chmod +x /home/*.sh

echo "Scritps were downloaded. please run '/home/flex-pre-clone.sh'"
echo
echo "Praparation of your first template will begin."
echo
echo "I will guide you through the preparation."
echo
