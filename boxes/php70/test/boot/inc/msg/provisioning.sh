#!/bin/bash

# ------------------------------------------------------------------------------
# Announce the start of the provisioning script.
# ------------------------------------------------------------------------------

read -r -d '' msg << EOF
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   PROVISIONING                                                               │
│                                                                              │
│   The local development box is being provisioned.                            │
│   Please wait.                                                               │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
EOF

echo "${msg}"
