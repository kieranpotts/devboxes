#!/bin/bash

# ------------------------------------------------------------------------------
# Install Node.
#
# This will install the v14.x LTS release of Node from the NodeSource package
# archives. @see //github.com/nodesource/distributions
#
# From local development boxes we should not do SSL key validation in requesting
# resources from the NPM registry over HTTPS, else `npm update` will return the
# error code `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`. The `strict-ssl=false` option
# is set at the global level.
# @see //github.com/npm/npm/issues/9580#issuecomment-288937937
#
# PM2, a process manager for Node applications, provides an easy way to
# daemonize application, so running them in the background as a service.
#
# To check installed versions.
#
#   $ nodejs -v
#   $ npm -v
#
# To check the status of the process unit:
#
#   $ systemctl status pm2-vagrant
#
# @see //nodejs.org/en/
# ------------------------------------------------------------------------------

startNewTask "Installing Node"

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo tee "/usr/etc/npmrc" <<EOF
strict-ssl=false
EOF

sudo npm install -g pm2

# PM2 startup script.
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup upstart -u vagrant --hp /home/vagrant
