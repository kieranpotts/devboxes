#!/bin/bash

# ------------------------------------------------------------------------------
# Configure Git.
#
# To view Git's configuration:
#
#   $ git config --list
#
# @see //git-scm.com/
# ------------------------------------------------------------------------------

startNewTask "Configuring Git"

[ ! -z "${git_user_name}" ] && sudo git config --global user.name "${git_user_name}"
[ ! -z "${git_user_email}" ] && sudo git config --global user.email "${git_user_email}"
