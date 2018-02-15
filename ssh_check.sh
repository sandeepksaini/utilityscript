#!/bin/bash -
#Purpose: To enable options in ssh_config for clear text password login and root user login using ssh service
#I have created this script specailly for my GCP instances and enable these options in one go by running this script

#Variable declarations
ssh_file='/etc/ssh/sshd_config'
per_bol1="$(grep "^\<PermitRootLogin yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol2="$(grep "^\<PermitRootLogin no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol3="$(grep "^#\<PermitRootLogin yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol4="$(grep "^#\<PermitRootLogin no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"

pwd_bol1="$(grep "^\<PasswordAuthentication yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
pwd_bol2="$(grep "^\<PasswordAuthentication no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
pwd_bol3="$(grep "^#\<PasswordAuthentication yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
pwd_bol4="$(grep "^#\<PasswordAuthentication no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"

#Delaring function for changing "PermitRootLogin" and "PasswordAuthentication" boolean values
function permit_login()
{
if [ ${per_bol1} -eq 0 ]
then
        echo success;exit 0
elif [ ${per_bol2} -eq 0 ]
then
        sed -i 's/^\<PermitRootLogin no\>/PermitRootLogin yes/g' ${ssh_file}
elif [ ${per_bol3} -eq 0 ]
then
        sed -i 's/^#\<PermitRootLogin yes\>/PermitRootLogin yes/g' ${ssh_file}
elif [ ${per_bol4} -eq 0 ]
then
        sed -i '/^#\<PermitRootLogin no\>/a PermitRootLogin yes' ${ssh_file}
else
        echo "PermitRootLogin yes" >> ${ssh_file}
fi
}

function password_auth()
{
if [ ${pwd_bol1} -eq 0 ]
then
        echo success;exit 0
elif [ ${pwd_bol2} -eq 0 ]
then
        sed -i 's/^\<PasswordAuthentication no\>/PasswordAuthentication yes/g' ${ssh_file}
elif [ ${pwd_bol3} -eq 0 ]
then
        sed -i 's/^#\<PasswordAuthentication yes\>/PasswordAuthentication yes/g' ${ssh_file}
elif [ ${pwd_bol4} -eq 0 ]
then
        sed -i '/^#\<PasswordAuthentication no\>/a PasswordAuthentication yes' ${ssh_file}
else
        echo "PasswordAuthentication yes" >> ${ssh_file}
fi
}


#Execution stage
cp -f ${ssh_file}{,_$(date +%b-%d-%T).bck}
permit_login
password_auth
systemctl restart sshd
