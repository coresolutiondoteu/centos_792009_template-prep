




#Create Machine-ID and show it
systemd-machine-id-setup
cat /etc/machine-id

##Tune this based on your environment 
hostnamectl set-hostname flex1 
nano /etc/hosts 
192.168.86.15 flex-gw 
192.168.86.16 flex1 
192.168.86.17 flex2 
192.168.86.18 flex3 

#Shutdown the firewall
systemctl disable firewalld
systemctl stop firewalld

Setup SSH from gateway to each node: How To Set Up SSH Keys on CentOS 7 | DigitalOcean 
