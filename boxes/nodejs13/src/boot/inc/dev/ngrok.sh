#!/bin/bash

# ------------------------------------------------------------------------------
# Install the client for the Ngrok service, which can be used to bore
# secure, introspectable tunnels to localhost servers.
#
# @see //ngrok.com/
# ------------------------------------------------------------------------------

startNewTask "Installing Ngrok"

# The `ngrok` package is available for Ubuntu 16.04 LTS (and later versions)
# from the Snap Store. @see //snapcraft.io/install/ngrok/ubuntu
sudo snap install ngrok
