#!/bin/bash

# ------------------------------------------------------------------------------
# Install the MailDev Node app.
#
# MailDev is not configured to start automatically on server boot and Nginx must
# be configured to serve the MailDev web interface.
#
# NPM must be already installed.
#
# @see //github.com/maildev/maildev
# ------------------------------------------------------------------------------

startNewTask "Installing MailDev"

sudo npm install -g maildev
