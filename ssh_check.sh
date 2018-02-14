#!/bin/bash -
#Purpose: To enable options in ssh_config for clear text password login and root user login using ssh service
#I have created this script specailly for my GCP instances and enable these options in one go by running this script

ssh_file='/etc/ssh/sshd_config'
per_bol=`egrep -i '^PermitRootLogin no|^#PermitRootLogin no' ${ssh_file}|wc -l`
pwd_bol=`egrep -i '^PasswordAuthentication no|^#PasswordAuthentication no' ${ssh_file}|wc -l`

per_bol1="$(grep "^\<PermitRootLogin yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol2="$(grep "^\<PermitRootLogin no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol3="$(grep "^#\<PermitRootLogin yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol4="$(grep "^#\<PermitRootLogin no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"

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

systemctl sshd restart



----------------

#!/bin/bash -xv
ssh_file=test
#cp -f ${ssh_file}{,_$(date +%b-%d-%T).bck}

string1="PermitRootLogin yes"
string2="PermitRootLogin no"

per_bol1="$(grep "^\<PermitRootLogin yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol2="$(grep "^\<PermitRootLogin no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol3="$(grep "^#\<PermitRootLogin yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
per_bol4="$(grep "^#\<PermitRootLogin no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"

pwd_bol1="$(grep "^\<PasswordAuthentication yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
pwd_bol2="$(grep "^\<PasswordAuthentication no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
pwd_bol3="$(grep "^#\<PasswordAuthentication yes\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"
pwd_bol4="$(grep "^#\<PasswordAuthentication no\>" ${ssh_file} 2>&1 1>/dev/null;echo $?)"

count=1

while [ ${count} -le 8 ]
do

for val in $per_bol{1..4} $pwd_bol{1..4}
do
        if [ ${val} -eq 0 ]
        then
                echo "success";
        elif [ ${val} -eq 0 ]
        then
                if [ ${count} -le 4 ]
                then
                        sed -i 's/^\<PermitRootLogin no\>/PermitRootLogin yes/g' ${ssh_file}
                else
                        sed -i 's/^\<PasswordAuthentication no\>/PermitRootLogin yes/g' ${ssh_file}
                fi
        elif [ ${val} -eq 0 ]
        then
                if [ ${count} -le 4 ]
                then
                        sed -i 's/^#\<PermitRootLogin yes\>/PermitRootLogin yes/g' ${ssh_file}
                else
                        sed -i 's/^#\<PasswordAuthentication yes\>/PasswordAuthentication yes/g' ${ssh_file}
                fi
        elif [ ${val} -eq 0 ]
        then
                if [ ${count} -le 4 ]
                then
                        sed -i '/^#\<PermitRootLogin no\>/a PermitRootLogin yes' ${ssh_file}
                else
                        sed -i 's/^#\<PasswordAuthentication no\>/PasswordAuthentication yes/g' ${ssh_file}
                fi
        else
                if [ ${per_bol1} -eq 1 -a ${per_bol2} -eq 1 -a ${per_bol3} -eq 1 -a ${per_bol4} -eq 1 ]
                then
                        echo "PermitRootLogin yes" >> ${ssh_file}
                elif [ ${per_bol1} -eq 1 -a ${per_bol2} -eq 1 -a ${per_bol3} -eq 1 -a ${per_bol4} -eq 1 -a ${pwd_bol1} -eq 1 -a ${pwd_bol2} -eq 1 -a ${pwd_bol3} -eq 1 -a ${pwd_bol4} -eq 1 ]
                then
                        echo "PasswordAuthentication yes" >> ${ssh_file}
                else
                        :
                fi
        fi
done

                ((count++))
done

---------------
for val in $per_bol{1..4} $pwd_bol{1..4}
do
        if [ ${val} -eq 0 ]
        then
                echo "success";
        elif [ ${val} -eq 0 ]
        then
                if [ ${per_bol1} -eq 1 -o ${per_bol2} -eq 1 -o ${per_bol3} -eq 1 -o ${per_bol4} -eq 1  ]
                then
                        sed -i 's/^\<PermitRootLogin no\>/PermitRootLogin yes/g' ${ssh_file}
                else
                        sed -i 's/^\<PasswordAuthentication no\>/PermitRootLogin yes/g' ${ssh_file}
                fi
        elif [ ${val} -eq 0 ]
        then
                if [ ${per_bol1} -eq 1 -o ${per_bol2} -eq 1 -o ${per_bol3} -eq 1 -o ${per_bol4} -eq 1  ]
                then
                        sed -i 's/^#\<PermitRootLogin yes\>/PermitRootLogin yes/g' ${ssh_file}
                else
                        sed -i 's/^#\<PasswordAuthentication yes\>/PasswordAuthentication yes/g' ${ssh_file}
                fi
        elif [ ${val} -eq 0 ]
        then
                if [ ${per_bol1} -eq 1 -o ${per_bol2} -eq 1 -o ${per_bol3} -eq 1 -o ${per_bol4} -eq 1  ]
                then
                        sed -i '/^#\<PermitRootLogin no\>/a PermitRootLogin yes' ${ssh_file}
                else
                        sed -i 's/^#\<PasswordAuthentication no\>/PasswordAuthentication yes/g' ${ssh_file}
                fi
        else
                if [ ${per_bol1} -eq 1 -a ${per_bol2} -eq 1 -a ${per_bol3} -eq 1 -a ${per_bol4} -eq 1  ]
                then
                        echo "PermitRootLogin yes" >> ${ssh_file}
                elif [ ${pwd_bol1} -eq 1 -a ${pwd_bol2} -eq 1 -a ${pwd_bol3} -eq 1 -a ${pwd_bol4} -eq 1 ]
                then
                        echo "PasswordAuthentication yes" >> ${ssh_file}
                        exit 0
                else
                        :
                fi
        fi
done


