
#!/bin/bash
### !!! ### sudo chmod a+x /*.sh

#Create Machine-ID and show it
systemd-machine-id-setup
cat /etc/machine-id

##Tune this based on your environment (line 10 will have second name as hostname for the next VM and IP addr on line 13-16 must be set by your environment) 
hostnamectl set-hostname flex-gw
## Idea, could I leverage variables - asking for a user imput for the IP variable, leveraging them also for the SSH keys creation?
#Add to the end of the hosts file these host records
echo '192.168.86.15 flex-gw' >> /etc/hosts 
echo '192.168.86.16 flex1' >> /etc/hosts 
echo '192.168.86.17 flex2' >> /etc/hosts
echo '192.168.86.18 flex3' >> /etc/hosts

#Shutdown the firewall
systemctl disable firewalld
systemctl stop firewalld

#Setup SSH from gateway to each node: How To Set Up SSH Keys on CentOS 7 | DigitalOcean
