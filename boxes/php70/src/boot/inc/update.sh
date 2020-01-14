#!/bin/bash

# ------------------------------------------------------------------------------
# System updates.
#
# - Set the system timezone to UTC.
# - Clean up any failed packages, cached from previous builds.
# - Fetch latest updates for all pre-installed software.
# ------------------------------------------------------------------------------

startNewTask "Updating the system"

sudo timedatectl set-timezone UTC

sudo apt-get -qq autoremove
sudo apt-get -qq --purge remove && sudo apt-get -qq autoclean

sudo apt-get -qq update > /dev/null
