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

# Additional variables are imported from the `boot/config.sh` file. All
# `source` commands use absolute paths, which allows the provisioning script
# to be run from any location in the VM.
if [ ! -f "${boot_dir}/config.sh" ]; then
  echo "--> config.sh file not found, exiting..."
  exit 1
else
  source "${boot_dir}/config.sh"
fi

# Load helper functions.
source "${boot_dir}/inc/functions.sh"

# Print start message.
source "${boot_dir}/inc/msg/start.sh"

# Update and install system utilities.
source "${boot_dir}/inc/sys/update.sh"
source "${boot_dir}/inc/sys/upgrade.sh"
source "${boot_dir}/inc/sys/utils.sh"
source "${boot_dir}/inc/sys/hosts.sh"

# Application software.
source "${boot_dir}/inc/app/nodejs.sh"
source "${boot_dir}/inc/app/nginx.sh"
source "${boot_dir}/inc/app/mariadb.sh"
source "${boot_dir}/inc/app/mongodb.sh"
source "${boot_dir}/inc/app/redis.sh"
source "${boot_dir}/inc/app/sendmail.sh"

# More developer and sysadmin tools.
source "${boot_dir}/inc/dev/git.sh"
source "${boot_dir}/inc/dev/htop.sh"
source "${boot_dir}/inc/dev/maildev.sh"
source "${boot_dir}/inc/dev/ngrok.sh"
source "${boot_dir}/inc/dev/tmux.sh"
source "${boot_dir}/inc/dev/vim.sh"
source "${boot_dir}/inc/dev/yarn.sh"

# Finalise.
source "${boot_dir}/inc/teardown.sh"
source "${boot_dir}/inc/msg/hello.sh"
source "${boot_dir}/inc/msg/finish.sh"

# On "vagrant ssh", immediately change directory to the synced directory.
if ! grep -q "cd ${synced_dir}" ~/.bashrc ; then
  echo "cd ${synced_dir}" >> ~/.bashrc
fi
