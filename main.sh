#!/bin/bash
nginx_dir1=/etc/nginx
nginx_dir2=/etc/nginx/conf.d
vhost_dir1=/var/www/vhost1

#update timezone
sudo su - root -c 'rm /etc/localtime'
sudo su - root -c 'ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime'

#install epel & remi
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

#update centos
sudo yum -y update

#install depencies
sudo yum -y install wget vim nano zip unzip git nginx php-fpm php-gd php-cli php-common php-gettext php-mysql php-odbc php-mcrypt php-xml php-xmlrpc php-curl php-xsl 

#update nginx
update_1()
{
	sudo su - root -c 'rm -f $nginx_dir1/nginx.conf'
	sudo su - root -c 'wget https://github.com/dwippoer/centos7-nginx/blob/master/nginx.conf -P $nginx_dir1'
}
udpate_2()
{
	if [ -d $nginx_dir2 ];
	then
		sudo wget https://github.com/dwippoer/centos7-nginx/blob/master/vhost1.conf -P $nginx_dir2;
	else
		sudo mkdir $nginx_dir2 && sudo wget https://github.com/dwippoer/centos7-nginx/blob/master/vhost1.conf -P $nginx_dir2;
	fi
}
update_vhost_dir()
{
	if [ ! -d $vhost_dir1 ];
	then
		sudo mkdir  


#upgrade php
sudo su - root -c 'sed -i "30s/enabled=0/c\enabled=1" /etc/yum.repos.d/remi.repo'
sudo yum -y upgrade php*
