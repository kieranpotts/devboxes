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

# Path to the `boot` directory which contains scripts that are used
# by this provisioning script.
boot_dir="${synced_dir}/boot"

# Additional variables are important from the `boot/variables.sh` file. All
# `source` commands use absolute paths, which allows the provisioning script
# the be run from any location in the VM.
if [ ! -f "${boot_dir}/variables.sh" ]; then
  echo "--> variables.sh file not found, exiting..."
  exit 1
else
  source "${boot_dir}/variables.sh"
fi

# Load helper functions.
source "${boot_dir}/inc/functions.sh"

# Print the "provisioning" message.
source "${boot_dir}/inc/msg/provisioning.sh"

# Add application hostnames to `/etc/hosts`.
source "${boot_dir}/inc/hosts.sh"

# Custom configuration of PHP.
source "${boot_dir}/inc/php.sh"

# Configure the hosting of the main application.
source "${boot_dir}/inc/main.sh"
