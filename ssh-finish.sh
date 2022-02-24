#!/bin/bash

echo
echo "////////////////////////////////////////////////////////////////////"
edho "/                                                                  /" 
echo "/ Please wait till the last cloned VM reboots, so you could login. /"
echo "/                                                                  /"
echo "/          If all cloned VMs booted up, login please.              /"
echo "/                                                                  /"
echo "/               Then press any key to continue.                    /"
echo "/                                                                  /"
echo "////////////////////////////////////////////////////////////////////"

sleep 15
read -n 1 -r -s -p "All VMs booted? Press any key to continue..."
echo

#Show current hostname
Current_Hostname=$(hostname)

#Defined Hostnames:
VM1_Hostname_var="flex-gw"
VM2_Hostname_var="flex1"
VM3_Hostname_var="flex2"
VM4_Hostname_var="flex3"

#SSH key echange with other nodes
if [ "$Current_Hostname" = $VM1_Hostname_var ]; then
    ssh-copy-id -i ~/.ssh/id_rsa.pub flex1
    ssh-copy-id -i ~/.ssh/id_rsa.pub flex2
    ssh-copy-id -i ~/.ssh/id_rsa.pub flex3
else
    if [ "$Current_Hostname" = $VM2_Hostname_var ]; then
        ssh-copy-id -i ~/.ssh/id_rsa.pub flex-gw
		ssh-copy-id -i ~/.ssh/id_rsa.pub flex2
		ssh-copy-id -i ~/.ssh/id_rsa.pub flex3
    else
        if [ "$Current_Hostname" = $VM3_Hostname_var ]; then
		    ssh-copy-id -i ~/.ssh/id_rsa.pub flex1
			ssh-copy-id -i ~/.ssh/id_rsa.pub flex-gw
			ssh-copy-id -i ~/.ssh/id_rsa.pub flex3
        else
		    if [ "$Current_Hostname" = $VM4_Hostname_var ]; then
				ssh-copy-id -i ~/.ssh/id_rsa.pub flex1
				ssh-copy-id -i ~/.ssh/id_rsa.pub flex-gw
				ssh-copy-id -i ~/.ssh/id_rsa.pub flex2
		     else
			echo
		     fi
        fi
    fi
fi
echo
#Cleaning up startup scripts in ~/.bash_profile
sed -i '' -e '$ d' ~/.bash_profile
sed -i '' -e '$ d' ~/.bash_profile
clear
echo
echo "//////////////////////////////////////////"
echo "/                                        /"
echo "/ Cloned VMs preparation have finished.  /"
echo "/ You can proceed with additional steps. /"
echo "/                                        /"
echo "/                        Thank you!      /"
echo "/                                        /"
echo "//////////////////////////////////////////"
sleep 5
clear
echo
echo                                ".."
echo     "############/           ,#####(        ####,         ####            .(/**********   .((*             /((       *(/,...*((*"
echo     "####/***/(#####*     *#####/    *#*    ####,         ####            .(,             .(,(/           /(,(     /(          ,(."
echo     "####,       (###( /#####*    /#####*   (###,         ####            .(,             .(, (/         // ,(    (*              "
echo     "####,        ########,    (#####.   .(#####,         ####            .(/,,,,,,,,,.   .(,  //       (/  ,(   .(.              "
echo     "####,       .##########(####(.   ,(########,         ####            .(,             .(,   /(     (/   ,(   .(.              "
echo     "####,      *####*  /######,   *#####(  (###,         ####            .(,             .(,    /(   (/    ,(    //            //"
echo     "##############(       *##########*     ############,.############,   .(,             .(,     *( (*     ,(     ,(*         //"
echo     "#########(/.             ,####,        (###########,.(###########,   .((((((((((((   .(.      *(*      .(        ,/(((((/."
echo
echo
echo                                                ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."                                                  
echo                                               ":OK0OOOOkkkOkOOOOkkkkkkkkkkkkkkkkkkkkkkO0Kk,"                                                 
echo                                             ".c0Ol'....................................'ckk;"                                                
echo                                            ".l0k;.            ..                         ,xO:."                                              
echo                                           ".d0x,...                                       'dOl."                                             
echo                                          ".x0d'                                            .dOo."                                            
echo                                         ",k0o'                                             .'oOd."                                           
echo                                        ";kOl...                                   .       ....lOx'"                                          
echo                                       ":Okc....  ..............................................:kx;"                                         
echo                                     ".cOk:.... .................................................;xk:"                                        
echo                                    ".lOd,.... ...................................................,dkc."                                      
echo                                   ".oOo' ... .....................................................'oOo."                                     
echo                                  "'dkl.     .................................................      .lOd'"                                    
echo                     ",:;::::;,.  ,dk:.                                           .;ccccccc,. .;;.   .cOx,"                                   
echo                    ".dOo:ccclxx,,oo;                                             .xKdccccc'  .xO'     ;xx;"                                  
echo                    ".ok,     :Ol,:;;clll;.  .;:. .,l:. .::.  .;looc,    .;c;cl;. .x0,        .xk'   .;lxkd,  .,:'   ':'"                     
echo                    ".oOocllloxd,.,oko::ckx:,;d0l':kKO:'c0d'':kOl::d0l',;:xXkcc;',:xKdllool,,;;xk,.,:xx:;;ox:,;cdxc;lxl."                     
echo                    ".lOl;:::;,..':ko..,'cOo,;ckx,okcxd,dO,.,oKOllldKO,.,:xK;.',;::xKo:ccc:',:;xk,';o0xcc:oOo,;:;ckOx,"                       
echo                     "lk,..'''',;,;kx'';;o0c.,;lOxOl.:OkOl.',lKOc;;cdc..';x0;.;:::;xO,..'''';;;dk,.,c0x;,,:l;.';cddldl."                      
echo                     "cx'      .''.;ddoodxc.   .oKx. .oXx.   .:xxooxx,   .o0,     .dO'        .ox.  .:dolldo. .:d:. .ld'"                     
echo                     "..        'cl,..',..      ...   ...       .,,.      ..       ..          ..     .';;'.   ..     ."                      
echo                                "'lo;.                                                              ...;:;'"                                  
echo                                 "'lo:.                                                          .....:ol,"                                   
echo                                  ".cd:..    ................................................. .....'col,"                                    
echo                                   ".coc.... ......................................................,ldl'"                                     
echo                                    ".:oc'........................................................;ldc."                                      
echo                                      ";ol,....................................................'':oo:."                                       
echo                                       ",ll;.... .............................................',:oo;."                                        
echo                                        "'ll;...                                         ....',col,"                                          
echo                                         ".cl:...                                       .....,col,"                                           
echo                                          ".cl:...                                    ......,coc'"                                            
echo                                           ".:l:..  ....................          .........,cl:."                                             
echo                                            ".;l:'........................................,cl:."                                              
echo                                              ",lc,'',,,,,,,'''''''''''''''''''''''''''',:ll;."                                               
echo                                               ",clcccccccccccccccccccccccccccccccccccccllc,"                                                 
echo                                                ".''''''''''''''''''''''''''''''''''''''''."                                                  
echo 
echo "End of the script."
