#!/bin/bash -x
#Purpose: To enable clear text password login and enable root user login using ssh service

ssh_file='/etc/ssh/sshd_configcp'
per_bol=`egrep -i '^PermitRootLogin no|^#PermitRootLogin no' ${ssh_file}|wc -l`
pwd_bol=`egrep -i '^PasswordAuthentication no|^#PasswordAuthentication no' ${ssh_file}|wc -l`

if [ ${per_bol} -ge 0 ];
then 
        sed -i -e 's/PermitRootLogin no/PermitRootLogin yes/g' ${ssh_file}
elif [ ${pwd_bol} -ge 0 ];
then
        sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' ${ssh_file}
fi
systemctl sshd restart
