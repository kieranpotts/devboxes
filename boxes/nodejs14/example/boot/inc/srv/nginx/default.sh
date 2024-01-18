#!/bin/bash

# ------------------------------------------------------------------------------
# A default server to handle invalid requests.
# ------------------------------------------------------------------------------

startNewTask "Configuring a default Nginx server"

# Application server configuration.
sudo touch /etc/nginx/sites-available/default.conf
sudo tee /etc/nginx/sites-available/default.conf << END

# Catch all requests to any other hostnames that may be pointing at this server,
# and redirect them to the main application. This makes it possible to configure
# hostname aliases simply by pointing more hostnames to the same IP address from
# your local "/etc/hosts" file.

server {
  listen 80 default_server;
  listen 443 ssl default_server;
  listen [::]:80 default_server;
  listen [::]:443 ssl default_server;

  server_name _;

  ssl_certificate ${path_to_ssl_crt};
  ssl_certificate_key ${path_to_ssl_key};

  return 301 https://${application_hostname}\$request_uri;
}

END

sudo ln -fs /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/

sudo nginx -t
sudo systemctl reload nginx
