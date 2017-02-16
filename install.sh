#!/bin/bash
install_nginx()
{
	sudo yum -y install nginx
	sudo systemctl start nginx && sudo systemctl enable nginx
}
install_nginx 
