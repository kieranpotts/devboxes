#!/bin/bash

# ==============================================================================
# VM startup script.
#
# Vagrant runs this script whenever the VM is started up.
#
# Use the startup script to:
#
# - The local source repository with the remote one, so updating the
#   application code to the latest development build.
# - Install/update the application's dependencies.
# - Start the Node.js application under PM2.
# ==============================================================================

# Capture input arguments.
# $1 = Absolute path to the directory in the guest VM that is mounted
#      from an directory on the host machine.
synced_dir=$1

# Path to the `boot` directory which contains scripts that are used
# by this provisioning script.
boot_dir="${synced_dir}/boot"

# Startup scripts may be used to start various processes as required for the
# application, or to update dependencies or create build artefacts, etc.
