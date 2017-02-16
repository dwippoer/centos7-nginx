#!/bin/bash

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

#start services
sudo systemctl start nginx && sudo systemctl enable nginx
sudo systemctl start php-fpm && sudo systemctl enable php-fpm

#
