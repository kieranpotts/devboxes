#!/bin/bash

# ------------------------------------------------------------------------------
# Install Yarn.
#
# Yarn is a popular alternative to the NPM package manager.
#
# To get the installed Yarn version:
#
#   $ yarn -v
#
# @see https://yarnpkg.com/lang/en/
# ------------------------------------------------------------------------------

startNewTask "Installing Yarn"

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list &> /dev/null

sudo apt-get update -qq > /dev/null
sudo apt-get install -y -qq --no-install-recommends yarn &> /dev/null

# Fix "EACCES permission denied" `scandir` error on some `yarn` commands.
sudo mkdir /home/vagrant/.config
sudo chown -R vagrant:vagrant /home/vagrant/.config
