#!/bin/bash

# ------------------------------------------------------------------------------
# Install Redis.
#
# @see //redis.io/
# ------------------------------------------------------------------------------

startNewTask "Installing Redis"

sudo apt-get -y install redis-server

sudo systemctl enable redis-server
sudo systemctl start redis-server

# //gist.github.com/kapkaev/4619127
sudo redis-cli config set stop-writes-on-bgsave-error no
