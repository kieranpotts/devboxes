#!/bin/bash

# ------------------------------------------------------------------------------
# Set a welcome message for when the user SSHes into the VM.
# ------------------------------------------------------------------------------

# Disable default messages by removing execute privileges.
sudo chmod -x /etc/update-motd.d/*

read -r -d '' msg << EOF
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   HELLO                                                                      │
│                                                                              │
│   You are logged in to your local development box.                           │
│   Type "exit" to leave again.                                                │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
EOF

echo "${msg}" | sudo tee /etc/motd > /dev/null
