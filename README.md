# centos_792009_template-prep
Shell script for VM preparation for cloning and automating VMs deployment

1) Install a new CentOS VM:

Centos 7.9 minimal ISO is fine, 2 vcpu, 4GB RAM
VMname: CentOS7_Template
hostname: DefaultHostname
user: root
password: your password
Set your current TimeZone 
Turn on the Networking and keep it in DHCP mode for now.

2) Power On VM and login inside with root/password and get your IP details

curl -L -o- https://bit.ly/3s5tDUI | bash

3) Make a snapshot of the template VM and start preparation for cloning.

curl -L -o- https://bit.ly/3scXNWx | bash

4) After VM planned shutdown, make clones and continue with Power on. Wait till the end and then Power another VM.

5) After you end with last VM, you can restart first Vm with reboot and wait till the end. Then another one. Last VM is already done. (3x reboot, on VM1, VM2 and VM3).

6) Done. (only 4 Clone VMs are expected in total)
