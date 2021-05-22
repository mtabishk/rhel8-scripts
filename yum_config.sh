#!/bin/bash

echo "-------------YUM configuration from mounted DVD------------------"

read -p "Enter the mount path of RHEL DVD ( use 'df -hT' to find it out): " mount_path

echo -e "\nStarting YUM Configuration\n"

touch /etc/yum.repos.d/rhel8dvd.repo

echo "[AppStream]" >> /etc/yum.repos.d/rhel8dvd.repo
echo "name=Yum from AppStream" >> /etc/yum.repos.d/rhel8dvd.repo
echo "baseurl=file://$mount_path/AppStream" >> /etc/yum.repos.d/rhel8dvd.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/rhel8dvd.repo

echo -e "\n" >> /etc/yum.repos.d/rhel8dvd.repo

echo "[BaseOS]" >> /etc/yum.repos.d/rhel8dvd.repo
echo "name=Yum from BaseOS" >> /etc/yum.repos.d/rhel8dvd.repo
echo "baseurl=file://$mount_path/BaseOS" >> /etc/yum.repos.d/rhel8dvd.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/rhel8dvd.repo

echo -e "\nCheck if yum is configured: "
echo $(yum repolist)

exit 0

