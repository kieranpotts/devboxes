#!/bin/bash

# ------------------------------------------------------------------------------
# Edit the `/etc/hosts` file.
#
# Vagrant is not used to manage the application hostname (`config.vm.hostname`).
# So we need to update `/etc/hosts` on the guest machine with the hostname. This
# is required by some CLI tools, such as cURL, to make requests back to the
# local application.
# ------------------------------------------------------------------------------

startNewTask "Configuring /etc/hosts"

sudo tee /etc/hosts <<EOF
127.0.0.1 localhost
EOF
