# centos_792009_template-prep
Shell script for VM preparation for cloning and automating VMs deployment

Install a new CentOS VM:
Centos 7.9 minimal ISO is fine, 2 vcpu, 4GB RAM
VMname: CentOS7_Template
hostname: ChangeMeCentOS79
user: root
password: your password
Set your current TimeZone 
Turn on the Networking and keep it in DHCP mode for now.

Power On VM and login inside with root/password and get your IP details
	a. curl -L -o- https://bit.ly/3s5tDUI | bash
 
 Make a snapshot of the template VM and start preparation for cloning.
 
	b. curl -L -o- https://bit.ly/3scXNWx | bash
  
 (only 4 VMs are expected)
