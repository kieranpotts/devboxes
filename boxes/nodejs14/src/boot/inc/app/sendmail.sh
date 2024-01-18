#!/bin/bash

# ------------------------------------------------------------------------------
# Install Sendmail.
#
# @see //www.proofpoint.com/us/products/email-protection/open-source-email-solution
# ------------------------------------------------------------------------------

startNewTask "Installing Sendmail"

sudo apt-get install -y sendmail

sudo systemctl enable sendmail
sudo systemctl start sendmail
