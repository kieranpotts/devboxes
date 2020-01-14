#!/bin/bash

# ------------------------------------------------------------------------------
# Install Vim.
#
# @see http://www.vim.org/
# ------------------------------------------------------------------------------

startNewTask "Installing Vim"

sudo apt-get -y -qq install vim &> /dev/null
