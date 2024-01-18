#!/bin/bash

# ==============================================================================
# VM startup script.
#
# Vagrant runs this script whenever the VM is started up.
#
# Startup scripts may be used to start various processes as required for the
# application, or to update dependencies or create build artifacts, etc.
# ==============================================================================

# Capture input arguments.
# $1 = Absolute path to the directory in the guest VM that is mounted
#      from an directory on the host machine.
synced_dir=$1

# Path to the `boot` directory. This is used to create absolute paths
# for all `source` commands, allowing the provisioning script to be
# run from any location in the VM.
boot_dir="${synced_dir}/boot"

# The environment configuration file is required.
if [ ! -f "${boot_dir}/.env" ]; then
  echo "--> Environment configuration file not found, exiting..."
  exit 1
fi

# Parse the contents of the `.env` files into variables.
set -o allexport
source "${boot_dir}/.env"
set +o allexport

# Print the "booting" message.
source "${boot_dir}/inc/msg/booting.sh"

echo "---> Starting the main application..."
sudo pm2 start ${synced_dir}/app/index.js --name "main"

# Print the "finished" message.
source "${boot_dir}/inc/msg/finish.sh"
