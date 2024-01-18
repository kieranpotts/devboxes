#!/bin/bash

# ------------------------------------------------------------------------------
# Edit the `/etc/hosts` file.
#
# Vagrant is not used to manage the application hostname (`config.vm.hostname`).
# ------------------------------------------------------------------------------

startNewTask "Configuring /etc/hosts"

sudo tee /etc/hosts <<EOF
127.0.0.1 vagrant localhost
EOF
