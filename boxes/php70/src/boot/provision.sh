#!/bin/bash

# ------------------------------------------------------------------------------
# Vagrant box provisioning script.
#
# Commands that require elevated privileges are prefixed `sudo`, which means
# this script can be run without elevated privileges. In the Vagrantfile:
#
#   script.privileged = false
# ------------------------------------------------------------------------------

# Capture input arguments.
# $1 = Absolute path to the directory in the guest VM that is mounted
#      from an directory on the host machine.
synced_dir=$1

# Path to the `boot` directory which contains scripts that are used
# by this provisioning script.
boot_dir="${synced_dir}/boot"

# Task counter.
i=0

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

# Print start message.
source "${boot_dir}/inc/msg/start.sh"

# Update and install system utilities.
source "${boot_dir}/inc/update.sh"
source "${boot_dir}/inc/upgrade.sh"
source "${boot_dir}/inc/utils.sh"
source "${boot_dir}/inc/hosts.sh"

# Developer and sysadmin tools.
source "${boot_dir}/inc/git.sh"
source "${boot_dir}/inc/vim.sh"
source "${boot_dir}/inc/htop.sh"
source "${boot_dir}/inc/tmux.sh"
source "${boot_dir}/inc/ngrok.sh"

# Application software.
source "${boot_dir}/inc/nginx.sh"
source "${boot_dir}/inc/mariadb.sh"
source "${boot_dir}/inc/php.sh"
source "${boot_dir}/inc/redis.sh"
source "${boot_dir}/inc/sendmail.sh"

# Finalise.
source "${boot_dir}/inc/teardown.sh"
source "${boot_dir}/inc/msg/hello.sh"
source "${boot_dir}/inc/msg/finish.sh"
