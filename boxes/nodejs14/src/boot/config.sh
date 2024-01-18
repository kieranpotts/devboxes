#!/bin/bash

# ------------------------------------------------------------------------------
# Provisioning configuration.
# ------------------------------------------------------------------------------

# -- DATABASE CONFIGURATION ----------------------------------------------------

# MySQL/MariaDB credentials.
mysql_rootpswd="root"
mysql_dbuser="mysql"
mysql_dbpswd="mysql"

# MongoDB credentials.
mongodb_dbuser="mongodb"
mongodb_dbpswd="mongodb"

# -- GIT CONFIGURATION ---------------------------------------------------------

# Don't provide default Git credentials out-of-the-box.
git_user_name=""
git_user_email=""
