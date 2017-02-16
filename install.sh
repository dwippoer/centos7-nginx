#!/bin/bash
dir1_nginx=/etc/nginx/conf.d

install_nginx()
{
	sudo yum -y install nginx
	sudo systemctl start nginx && sudo systemctl enable nginx
}
install_nginx

#check dir nginx/conf.d
if [ -d /etc/nginx/conf.d ];
then
	sudo wget https://github.com/dwippoer/centos7-nginx/blob/master/vhost1.conf -P $dir1_nginx;
else
	sudo mkdir $dir1_nginx && sudo wget https://github.com/dwippoer/centos7-nginx/blob/master/vhost1.conf -P $dir1_nginx;
fi

#update nginx
sudo rm -f /etc/nginx/nginx.conf && sudo wget https://github.com/dwippoer/centos7-nginx/blob/master/nginx.conf -P /etc/nginx

#install php
sudo yum -y install php-fpm php-mysql php-cli php-gd php-mcrypt php-mbstring php-curl php-common php-gettext php-xml php-xmlrpc php-xsl php-json php-odbc

sudo systemctl start php-fpm 
sudo systemctl enable php-fpm

#upgrade to php5.6
sudo yum -y upgrade php*

#update fpm pool
sudo su - root -c 'sed -i "/user = apache/c\user = nginx" /etc/php-fpm.d/www.conf'
sudo su - root -c 'sed -i "/group = apache/c\group = nginx" /etc/php-fpm.d/www.conf'

#install iptables
sudo yum -y install iptables-services 
sudo systemctl start iptables && sudo iptables -F && sudo systemctl enable iptables
sudo su - root -c 'echo "iptables-restore < /etc/iptables.rules" > /etc/rc.local'
