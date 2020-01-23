#!/bin/bash

# ------------------------------------------------------------------------------
# Provisioning variables.
# ------------------------------------------------------------------------------

# -- DATABASE CONFIGURATION ----------------------------------------------------

# MySQL/MariaDB credentials. The box will provide an empty database called `app`
# so that application-specific provisioning scripts do not need to configure
# a database for the hosted application.
mysql_rootpswd="root"
mysql_dbname="app"
mysql_dbuser="mysql"
mysql_dbpswd="mysql"

# MongoDB credentials.
mongodb_dbname="app"
mongodb_dbuser="mongodb"
mongodb_dbpswd="mongodb"

# -- GIT CONFIGURATION ---------------------------------------------------------

# Don't provide default Git credentials out-of-the-box.
git_user_name=""
git_user_email=""
