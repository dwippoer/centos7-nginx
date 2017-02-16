#!/bin/bash
nginx_dir1="/etc/nginx"
nginx_dir2="/etc/nginx/conf.d"
vhost_dir1="/var/www/vhost1"
temp_dir="/tmp/install"
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

#clone repo
git clone https://github.com/dwippoer/centos7-nginx.git $temp_dir

#update nginx
update_1()
{
	sudo rm -f $nginx_dir1/nginx.conf && sudo cp $temp_dir/nginx.conf $nginx_dir1
}

update_2()
{
	if [ -d $nginx_dir2 ];
	then
		sudo cp $temp_dir/vhost1.conf $nginx_dir2;
	else
		sudo mkdir $nginx_dir2 && sudo cp $temp_dir/vhost1.conf $nginx_dir2;
	fi
}

update_www_dir()
{
	if [ ! -d "/var/www" ];
	then
		sudo mkdir /var/www;
	fi
	
	sudo chmod 775 /var/www && sudo chown -R nginx:nginx /var/www
} 

check_vhost_dir()
{
	if [ ! -d $vhost_dir1 ];
	then
		sudo mkdir $vhost_dir1;
	fi
	sudo chmod 775 $vhost_dir1 && sudo chown -R nginx:nginx $vhost_dir1
}
update_1
update_2
update_www_dir
check_vhost_dir

#start services
sudo systemctl start nginx && sudo systemctl enable nginx
sudo systemctl start php-fpm && sudo systemctl enable php-fpm

#upgrade php
sudo su - root -c 'sed -i "30s/enabled=0/enabled=1/" /etc/yum.repos.d/remi.repo'
sudo yum -y upgrade php*
