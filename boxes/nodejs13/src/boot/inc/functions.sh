#!/bin/bash

# ------------------------------------------------------------------------------
# Functions that are used throughout the provisioning scripts.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Print a new message to inform the user
# a new provisioning task is starting.
#
# @global i Task incrementer.
# @param  1 Mesasage to print.
# @return void
#
function startNewTask {
  ((i++)) # Increment the global task counter.
  echo "--> ${i}. $1..."
}
