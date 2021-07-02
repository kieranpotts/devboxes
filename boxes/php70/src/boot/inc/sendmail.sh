#!/bin/bash

# ------------------------------------------------------------------------------
# SENDMAIL
# ------------------------------------------------------------------------------

startNewTask "Installing Sendmail"

sudo apt-get install -y sendmail

sudo systemctl enable sendmail
sudo systemctl start sendmail
