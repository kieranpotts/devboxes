#!/bin/bash

# ==============================================================================
# Provisioning variables.
# ==============================================================================

# -- HOSTNAME ------------------------------------------------------------------

# The hostname and optional alias from which the main hosted application
# will be served.
#
# For local development it is recommended to NOT use any of the official
# Internet TLDs, to clearly separate local from global domains.
# @see //en.wikipedia.org/wiki/List_of_Internet_top-level_domains
application_hostname="php70.devbox.local"
application_alias="www.php70.devbox.local"

# The main application server root directory (from where it will be served).
application_server_rootdir="${synced_dir}/app"
