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


