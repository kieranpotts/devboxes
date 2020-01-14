#!/bin/bash

# ------------------------------------------------------------------------------
# Install Git.
#
# @see https://git-scm.com/
# ------------------------------------------------------------------------------

startNewTask "Installing Git"

sudo apt-get -y -qq install git &> /dev/null

git config --global user.name "${git_user_name}"
git config --global user.email "${git_user_email}"

# To view Git's configuration:
# `git config --list`
