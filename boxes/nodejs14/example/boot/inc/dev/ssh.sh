#!/bin/bash

# ------------------------------------------------------------------------------
# SSH configuration.
# ------------------------------------------------------------------------------

startNewTask "Installing SSH keys"

if [ ! -z "${ssh_public_key}" ] && [ ! -z "${ssh_private_key}" ]; then

  # Install the public/private key pair.
  echo "${ssh_public_key}" > /home/vagrant/.ssh/id_rsa.pub
  echo "${ssh_private_key}" > /home/vagrant/.ssh/id_rsa

  # Set appropriate permissions on the public/private key files.
  chmod 600 /home/vagrant/.ssh/id_rsa
  chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
  chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub

  # Add the private key to the SSH agent. If the private key is passphrase-locked,
  # the "ssh-add" utility will prompt the user to input the passphrase.
  eval "$(ssh-agent -s)"
  ssh-add /home/vagrant/.ssh/id_rsa

fi
