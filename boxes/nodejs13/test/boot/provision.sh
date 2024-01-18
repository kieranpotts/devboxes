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

echo "${boot_dir}"

# The environment configuration file is required.
if [ ! -f "${boot_dir}/.env" ]; then
  echo "--> Environment configuration file not found, exiting..."
  exit 1
fi

# Parse the contents of the `.env` files into variables.
set -o allexport
source "${boot_dir}/.env"
set +o allexport

# Load helper functions.
source "${boot_dir}/inc/functions.sh"

# Print the "provisioning" message.
source "${boot_dir}/inc/msg/provisioning.sh"

# Configure the serving of the main application.
source "${boot_dir}/inc/srv/main/hosts.sh"
source "${boot_dir}/inc/srv/main/ssl.sh"
source "${boot_dir}/inc/srv/main/nginx.sh"
