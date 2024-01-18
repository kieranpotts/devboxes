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

# Set default options for "mysql" commands run by the "vagrant" user. By default
# connect using the root user. This is required for the automated DB migrations.
# @see //dev.mysql.com/doc/refman/8.0/en/option-files.html
cat > /home/vagrant/.my.cnf << END
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
END
