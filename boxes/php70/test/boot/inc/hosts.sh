#!/bin/bash

# ------------------------------------------------------------------------------
# Edit the `/etc/hosts` file.
#
# This is required by some CLI tools, such as cURL, to make requests back to the
# local application.
# ------------------------------------------------------------------------------

startNewTask "Configuring /etc/hosts"

sudo tee -a /etc/hosts <<EOF > /dev/null
127.0.0.1 ${application_hostname}
EOF
