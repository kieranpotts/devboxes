#!/bin/bash

# ------------------------------------------------------------------------------
# Edit the `/etc/hosts` file.
# ------------------------------------------------------------------------------

startNewTask "Configuring /etc/hosts"

sudo tee /etc/hosts <<EOF
127.0.0.1 vagrant localhost
EOF
