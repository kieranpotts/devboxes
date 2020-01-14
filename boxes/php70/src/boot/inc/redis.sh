#!/bin/bash

# ------------------------------------------------------------------------------
# Install Redis.
# ------------------------------------------------------------------------------

startNewTask "Installing Redis"

sudo apt-get -y -qq install redis-server &> /dev/null

sudo systemctl enable redis-server &> /dev/null
sudo systemctl start redis-server > /dev/null

# https://gist.github.com/kapkaev/4619127
sudo redis-cli config set stop-writes-on-bgsave-error no
