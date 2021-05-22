#!/bin/bash

echo "---------Starting Docker Configuration------------"

touch /etc/yum.repos.d/dockerconf.repo

echo "[docker]" >> /etc/yum.repos.d/dockerconf.repo
echo "name=Packages from Docker repository" >> /etc/yum.repos.d/dockerconf.repo
echo "baseurl=https://download.docker.com/linux/centos/7/x86_64/stable/" >> /etc/yum.repos.d/dockerconf.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/dockerconf.repo

yum clean all

echo "$(yum repolist)"

read -p "Is docker repo configured: (yes/no)     " val
if [ $val = "no" ]
then
	exit 1
fi

echo "$(yum install docker-ce --nobest -y)"

echo -e "\nAdding firewall rules for docker\n"

firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --reload

echo "$(firewall-cmd --list-all)"

systemctl enable docker --now

echo "$(docker info)"

echo "SUCCESS"

exit 0

