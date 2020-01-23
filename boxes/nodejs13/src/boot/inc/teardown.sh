#!/bin/bash

# ------------------------------------------------------------------------------
# Clean up disk space.
# ------------------------------------------------------------------------------

# Remove package dependencies that are no longer required.
sudo apt-get -y -qq autoremove &> /dev/null

# Remove APT cache.
sudo apt-get -y -qq clean

# Clear Bash history.
cat /dev/null > ~/.bash_history && history -c
