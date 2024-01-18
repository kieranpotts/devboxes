#!/bin/bash

# ------------------------------------------------------------------------------
# Install MongoDB and add an empty database and default user.
#
# @see //www.mongodb.com/
# ------------------------------------------------------------------------------

startNewTask "Installing MongoDB"

sudo apt-get -y install mongodb

mongo admin --eval "db.createUser({ user: '$mongodb_dbuser', pwd: '$mongodb_dbpswd', roles: [ { role: 'root', db: '${mongodb_dbname}' } ] });"

sudo service mongodb stop
sudo sed -i 's/bindIp\: 127\.0\.0\.1/bindIp\: 0\.0\.0\.0/' /etc/mongodb.conf
sudo service mongodb start
