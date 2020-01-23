#!/bin/bash

# ------------------------------------------------------------------------------
# Install tmux.
#
# @see https://github.com/tmux/tmux/wiki
# ------------------------------------------------------------------------------

startNewTask "Installing tmux"

sudo apt-get -y -qq install tmux &> /dev/null
