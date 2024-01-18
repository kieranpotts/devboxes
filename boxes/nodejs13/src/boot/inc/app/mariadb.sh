#!/bin/bash

# ------------------------------------------------------------------------------
# Installs MariaDB v10.2.
#
# @see //mariadb.org/
# ------------------------------------------------------------------------------

startNewTask "Installing MariaDB"

sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password ${mysql_rootpswd}"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password ${mysql_rootpswd}"

sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb https://mirrors.evowise.com/mariadb/repo/10.2/ubuntu '$(lsb_release -cs)' main'
sudo apt-get update
sudo apt-get -y install mariadb-server

# Add databases and a non-root user.
mysql -uroot -p${mysql_rootpswd} -e "CREATE DATABASE ${mysql_dbname} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -uroot -p${mysql_rootpswd} -e "CREATE USER '${mysql_dbuser}'@'localhost' IDENTIFIED BY '${mysql_dbpswd}';"
mysql -uroot -p${mysql_rootpswd} -e "GRANT ALL PRIVILEGES ON *.* TO '${mysql_dbuser}'@'localhost';"
mysql -uroot -p${mysql_rootpswd} -e "GRANT ALL PRIVILEGES ON ${mysql_dbname}.* TO '${mysql_dbuser}'@'localhost'"
mysql -uroot -p${mysql_rootpswd} -e "FLUSH PRIVILEGES;"

echo "
[mysql]
user=${mysql_dbuser}
password=${mysql_dbpswd}
host=localhost

[mysqladmin]
user=${mysql_dbuser}
password=${mysql_dbpswd}
host=localhost

[mysqldump]
user=${mysql_dbuser}
password=${mysql_dbpswd}
host=localhost
" | tee ~/.my.cnf
