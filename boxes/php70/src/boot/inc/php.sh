#!/bin/bash

# ------------------------------------------------------------------------------
# Installs PHP v7.0.
#
# PHP 7.0 is not available from Ubuntu 18's default package repository. Instead,
# this script uses the binaries repository maintained by Ondřej Surý.
#
# @see //www.php.net/
# ------------------------------------------------------------------------------

startNewTask "Installing PHP"

sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

sudo apt-get -y install php7.0-fpm
sudo systemctl start php7.0-fpm

sudo systemctl enable php7.0-fpm

phpfpm_user_ini_path=/etc/php/7.0/fpm/conf.d/user.ini
phpcli_user_ini_path=/etc/php/7.0/cli/conf.d/user.ini

# Fix path FPM setting.
echo 'cgi.fix_pathinfo = 0' | sudo tee -a ${phpfpm_user_ini_path}

# Enable only core PHP modules by default. The "common" package should be
# included with php-fpm, anyway. It bundles curl, fileinfo, json, phar and zip.
sudo apt-get -y install php7.0-common
sudo apt-get -y install php7.0-cli

# Many PHP applications and libraries make use of the mbstring module.
# Let's enable it my default.
sudo apt-get -y install php7.0-mbstring

# Install the extensions required to connect with MySQL/MariaDB and Redis.
sudo apt-get -y install php7.0-mysql
sudo apt-get -y install php7.0-redis

# Install Curl (Client URL Library).
# @see //php.net/manual/en/book.curl.php
sudo apt-get -y install php7.0-curl

# Install the popular GD image processing library.
# @see //php.net/manual/en/book.image.php
sudo apt-get -y install php7.0-gd

# No other PHP modules are enabled by default. These are some other modules that
# could be enabled via the provisioning scripts for individual box instances:
# sudo apt-get -y install php7.0-bcmath
# sudo apt-get -y install php7.0-bz2
# sudo apt-get -y install php7.0-cgi
# sudo apt-get -y install php7.0-dev # Includes pecl.
# sudo apt-get -y install php7.0-dom
# sudo apt-get -y install php7.0-imap
# sudo apt-get -y install php7.0-intl
# sudo apt-get -y install php7.0-mcrypt
# sudo apt-get -y install php7.0-odbc
# sudo apt-get -y install php7.0-pspell
# sudo apt-get -y install php7.0-tidy
# sudo apt-get -y install php7.0-xmlrpc
# sudo apt-get -y install php7.0-zip

# Custom PHP settings will be saved in the user's ini config.
echo 'display_startup_errors = On' | sudo tee -a ${phpfpm_user_ini_path}
echo 'display_errors = On' | sudo tee -a ${phpfpm_user_ini_path}
echo 'error_reporting = E_ALL ^ E_DEPRECATED' | sudo tee -a ${phpfpm_user_ini_path} # Hide deprecation notices.
echo 'log_errors_max_len = 1024' | sudo tee -a ${phpfpm_user_ini_path}

# Short <? PHP tags are still found in WordPress plugins and the like.
echo 'short_open_tag = On' | sudo tee -a ${phpfpm_user_ini_path}

# Provide decent resources for long-running and intensive scripts.
echo 'max_execution_time = 360' | sudo tee -a ${phpfpm_user_ini_path}
echo 'request_terminate_timeout = 360' | sudo tee -a ${phpfpm_user_ini_path}
echo 'memory_limit = 256M' | sudo tee -a ${phpfpm_user_ini_path}
echo 'post_max_size = 32M' | sudo tee -a ${phpfpm_user_ini_path}
echo 'upload_max_filesize = 32M' | sudo tee -a ${phpfpm_user_ini_path}

# Disable PHP Zend OPcache. This is a development environment, after all.
echo 'opache.enable = 0' | sudo tee -a ${phpfpm_user_ini_path}

# Set an environment variable that can be used for feature-toggling, and config-
# swapping, in the application.
echo "env[APPLICATION_HOST] = 'development'" | sudo tee -a ${phpfpm_user_ini_path}

# Install Composer, the de facto package manager for PHP.
EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")
php composer-setup.php
rm composer-setup.php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod 755 /usr/local/bin/composer

# Install Xdebug and enable stack traces.
# Note: the remote_host setting is the IP address that the guest machine can use
# to communicate with the host machine. Normally, this will be 10.0.2.2 - but it
# differ sometimes. Run the following command to find out the correct gateway IP
# address: netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10
sudo apt-get -y install php7.0-xdebug

xdebug_config='
xdebug.extended_info=1
xdebug.remote_connect_back=1
xdebug.remote_enable=1
xdebug.remote_port=9000
xdebug.max_nesting_level=512
xdebug.show_error_trace=1
'
echo "${xdebug_config}" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini

sudo systemctl restart php7.0-fpm
