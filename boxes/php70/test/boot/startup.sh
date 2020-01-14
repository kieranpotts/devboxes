#!/bin/bash

# ==============================================================================
# VM startup script.
#
# Vagrant runs this script whenever the VM is started up.
#
# Startup scripts may be used to start various processes as required for the
# application, or to update dependencies or create build artefacts, etc.
# ==============================================================================

# Capture input arguments.
# $1 = Absolute path to the directory in the guest VM that is mounted
#      from an directory on the host machine.
synced_dir=$1

# Path to the `boot` directory which contains scripts that are used
# by this startup script.
boot_dir="${synced_dir}/boot"

# Startup scripts go here...
