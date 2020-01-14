#!/bin/bash

# ------------------------------------------------------------------------------
# Announce completion of the server provisioning script.
# ------------------------------------------------------------------------------

read -r -d '' msg << EOF
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   FINISHED                                                                   │
│                                                                              │
│   The local development box is ready.                                        │
│   Running Node.js applications are listed below.                             │
│   Type "vagrant ssh" to log in.                                              │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
EOF

echo "${msg}"
