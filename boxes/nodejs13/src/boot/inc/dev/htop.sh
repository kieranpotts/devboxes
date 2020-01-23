#!/bin/bash

# ------------------------------------------------------------------------------
# Install htop.
#
# @see https://hisham.hm/htop/
# ------------------------------------------------------------------------------

startNewTask "Installing htop"

sudo apt-get -y -qq install htop &> /dev/null
