#!/bin/bash

# ------------------------------------------------------------------------------
# Announce completion of the server provisioning script.
# ------------------------------------------------------------------------------

read -r -d '' msg << EOF
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   FINISHED                                                                   │
│                                                                              │
│   The local development box is provisioned.                                  │
│   Type "vagrant ssh" to log in.                                              │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
EOF

echo "${msg}"
