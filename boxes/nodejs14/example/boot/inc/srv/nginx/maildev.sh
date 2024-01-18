#!/bin/bash

# ------------------------------------------------------------------------------
# Configure Nginx to serve the main application.
#
# @see //github.com/maildev/maildev
# ------------------------------------------------------------------------------

startNewTask "Configuring Nginx for MailDev"

sudo touch /etc/nginx/sites-available/${maildev_hostname}.conf
sudo tee /etc/nginx/sites-available/${maildev_hostname}.conf << END

server {

  # -- ROUTING: HTTP to HTTPS --------------------------------------------------

  listen 80;
  listen [::]:80;

  server_name ${maildev_hostname};

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  return 301 https://\$host\$request_uri;

}

server {

  # -- ROUTING -----------------------------------------------------------------

  listen 443 ssl;
  listen [::]:443 ssl;

  server_name ${maildev_hostname};

  # -- LOGGING -----------------------------------------------------------------

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log warn;

  # -- SSL/TLS -----------------------------------------------------------------

  ssl_certificate ${path_to_ssl_crt};
  ssl_certificate_key ${path_to_ssl_key};

  # -- SERVER ------------------------------------------------------------------

  location / {
    proxy_pass http://127.0.0.1:1080;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_cache_bypass \$http_upgrade;
  }

}

END

sudo ln -fs /etc/nginx/sites-available/${maildev_hostname}.conf /etc/nginx/sites-enabled/

# Test and enable this configuration.
sudo nginx -t
sudo systemctl reload nginx
