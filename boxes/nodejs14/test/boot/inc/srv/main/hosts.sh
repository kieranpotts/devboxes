#!/bin/bash

# ------------------------------------------------------------------------------
# Configure /etc/hosts.
#
# Sendmail (and other tools) requires the server's internal hostname, the output
# of the `hostname` command, to point to `127.0.0.1`. The hostname is configured
# in the `/etc/hostname` file.
# ------------------------------------------------------------------------------

startNewTask "Configuring /etc/hosts"

echo "${application_hostname}" | sudo tee /etc/hostname > /dev/null

sudo tee /etc/hosts <<EOF > /dev/null
127.0.0.1 ${application_hostname} ${application_alias} vagrant localhost
EOF
