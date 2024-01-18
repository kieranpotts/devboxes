#!/bin/bash

# ==============================================================================
# VM provisioning script.
#
# Use this script to install additional software that is required for a
# particular application.
#
# Commands that require elevated privileges are prefixed `sudo`, which means
# this script can be run without elevated privileges. In the Vagrantfile:
#
#   script.privileged = false
# ==============================================================================

# Capture input arguments.
# $1 = Absolute path to the directory in the guest VM that is mounted
#      from an directory on the host machine.
synced_dir=$1

# Path to the `boot` directory. This is used to create absolute paths
# for all `source` commands, allowing the provisioning script to be
# run from any location in the VM.
boot_dir="${synced_dir}/boot"

# Parse the contents of the "config.sh" file into shell variables - if there's a
# ".env" file, use it to override the defaults.
set -o allexport
source "${boot_dir}/config.sh"
if [ -f "${boot_dir}/.env" ]; then
  source "${boot_dir}/.env"
fi
set +o allexport

# Load helper functions.
source "${boot_dir}/inc/functions.sh"

# Print the "provisioning" message.
source "${boot_dir}/inc/msg/provisioning.sh"

# Git configuration and SSH keys.
source "${boot_dir}/inc/dev/git.sh"
source "${boot_dir}/inc/dev/ssh.sh"

# Global serving configuration.
source "${boot_dir}/inc/srv/hosts.sh"
source "${boot_dir}/inc/srv/ssl.sh"

# Nginx servers.
source "${boot_dir}/inc/srv/nginx/main.sh"
source "${boot_dir}/inc/srv/nginx/maildev.sh"
source "${boot_dir}/inc/srv/nginx/default.sh"
