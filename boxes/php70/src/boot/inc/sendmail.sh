#!/bin/bash

# ------------------------------------------------------------------------------
# SENDMAIL
# ------------------------------------------------------------------------------

startNewTask "Installing Sendmail"

sudo apt-get install -y sendmail &> /dev/null

sudo systemctl enable sendmail &> /dev/null
sudo systemctl start sendmail > /dev/null
