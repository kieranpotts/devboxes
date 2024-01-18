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

# -- GIT CONFIGURATION ---------------------------------------------------------

git_user_name="Developer"
git_user_email="hello@devbox.local"
