#!/bin/bash

# ------------------------------------------------------------------------------
# Functions that are used throughout the provisioning scripts.
# ------------------------------------------------------------------------------

# Task counter.
i=0

##
# Print a new message to inform the user
# a new provisioning task is starting.
#
# @global i Task incrementer.
# @param  1 Mesasage to print.
# @return void
#
function startNewTask {
  # Increment the global task counter.
  ((i++))

  # Print message.
  read -r -d '' msg << EOF
+------------------------------------------------------------------------------+
  STEP ${i}
  $1...
+------------------------------------------------------------------------------+
EOF
  echo "${msg}"

  # Give the user a moment to read the message
  # before more information is printed to the terminal.
  sleep 2s
}
