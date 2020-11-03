#!/bin/bash -
##Purpose : Installation of DaNdiFied Yum
#Comment from comment-dnf branch
#Just another comment
dnf_dir="/tmp/dnf-package"
dnf_link="http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/dnf-0.6.4-2.sdl7.noarch.rpm"
dnf_conf_link="http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/dnf-conf-0.6.4-2.sdl7.noarch.rpm"
py3_link="http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/python-dnf-0.6.4-2.sdl7.noarch.rpm"

#Download the packages
mkdir -p ${dnf_dir};cd ${dnf_dir}
for download in ${dnf_link} ${dnf_conf_link} ${py3_link}
do
  wget -q -P ${dnf_dir} ${download}
done
yum -q -y install dnf-0.6.4-2.sdl7.noarch.rpm dnf-conf-0.6.4-2.sdl7.noarch.rpm python-dnf-0.6.4-2.sdl7.noarch.rpm
cd -
printf "\n Deleting the ${dnf_dir}. Please type yes if dir is correct \n"
rm -ir ${dnf_dir}
printf "\n Installation Successfull - \n Path of executable is:  `which dnf` \n"
