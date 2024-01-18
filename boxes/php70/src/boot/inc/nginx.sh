#!/bin/bash

# ------------------------------------------------------------------------------
# Install Nginx.
#
# - Nginx's default test page is removed.
# - Nginx's default website is disabled (but its configuration is kept).
# - Nginx's log files are created.
# - Nginx is set to run automatically at system startup.
#
# To test which version of Nginx is installed:
#
#   $ nginx -v
#
# @see //www.nginx.com/
# ------------------------------------------------------------------------------

startNewTask "Installing Nginx"

sudo apt-get -y install nginx

sudo rm -rf /var/www/html
sudo rm -f /etc/nginx/sites-enabled/default
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/_example.conf

sudo touch /var/log/nginx/access.log
sudo touch /var/log/nginx/error.log

sudo systemctl start nginx
sudo systemctl enable nginx
