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
# @see //yarnpkg.com/lang/en/
# ------------------------------------------------------------------------------

startNewTask "Installing Yarn"

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install -y --no-install-recommends yarn

# Fix "EACCES permission denied" `scandir` error on some `yarn` commands.
sudo mkdir /home/vagrant/.config
sudo chown -R vagrant:vagrant /home/vagrant/.config
