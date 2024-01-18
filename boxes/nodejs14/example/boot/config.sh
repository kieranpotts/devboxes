#!/bin/bash

# ==============================================================================
# Default configuration for provisioning of the development VM.
#
# These defaults can be overridden by including a file called `.env` in the same
# directory. `.env` files will be excluded from source control).
# ==============================================================================

# -- MAIN APPLICATION ----------------------------------------------------------

# The FQDN from which the application will be served.
#
# For local development it is best practice to use one of the reserved top-level
# domain names such as `.local` or `.localhost`. The `.dev` TLD is now an active
# TLD in the global DNS system and should not be used.
# @see //en.wikipedia.org/wiki/Top-level_domain#Reserved_domains
application_hostname="devbox.local"
application_alias="www.devbox.local"

# The main application server root directory, from where
# static files are served.
application_rootdir="${synced_dir}/app"

# -- OTHER APPLICATIONS --------------------------------------------------------

# Hostname for the MailDev application.
maildev_hostname="mail.devbox.local"

# -- SSL CERTS -----------------------------------------------------------------

# A single self-signed SSL certificate will be generated and shared by all apps.
# The name of the SSL certificate files (excluding file extensions) will be:
sslcert_file_name="star.devbox.local"

# The "common name" is the primary domain from which the main app will be served
# — this could be a wildcard domain such as "*.example.local".
sslcert_common_name="*.devbox.local"

# Optionally you can add up to three other domains that will be added to the SSL
# certificate.
sslcert_alt_name_1=""
sslcert_alt_name_2=""
sslcert_alt_name_3=""

# -- GIT -----------------------------------------------------------------------

# Your name and email address is required if you want to use "git" commands from
# the command line inside the VM.
git_user_name=""
git_user_email=""

# -- SSH KEYs ------------------------------------------------------------------

# To use SSH to interact with external services — including remote Git servers —
# from within the virtual machine, config a public/profile key pair. This may be
# the same keys you use to authenticate from your computer.  The .env file isn't
# committed to the code repository so your local private key will stay private.
#
# To generate a new public/private key pair, run the following command from your
# terminal:
#
#   $ ssh-keygen -t rsa -b 4096 -N "" -C "your_name"
#
# Optionally, the private key may be protected with a passphrase. If so you will
# be prompted to enter this passphrase when the VM is configured.
#
# Copy the keys to the "ssh_public_key" and "ssh_private_key" variables - below.
# The public key also needs to be distributed to remote services such as GitLab.
#
#   $ cat id_rsa.pub  # Public key
#   $ cat id_rsa      # Private key
#
# The public/private keys will be installed for the "vagrant" user in the VM. If
# you do not want to install public/private keys, leave these variables blank.
#
# @see //linux.die.net/man/1/ssh-keygen

ssh_public_key="ssh-rsa abcdef...== Your Name"

ssh_private_key="-----BEGIN OPENSSH PRIVATE KEY-----
abcdef==
-----END OPENSSH PRIVATE KEY-----"
