#!/bin/bash

# ------------------------------------------------------------------------------
# Configure Nginx to serve the main application.
#
# To test for syntax errors in Nginx's configuration:
#
#   $ sudo nginx -t
# ------------------------------------------------------------------------------

startNewTask "Configuring Nginx"

# Application server configuration.
echo "
server {
  listen 80;
  listen [::]:80;

  server_name ${application_hostname} ${application_alias};

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  # Redirect all non-SSL requests to SSL.
  return 301 https://\$host\$request_uri;
}

server {
  listen 443;
  listen [::]:443 default ssl;

  server_name ${application_hostname} ${application_alias};

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  ssl on;
  ssl_certificate ${application_ssl_crt_path};
  ssl_certificate_key ${application_ssl_key_path};

  location / {

    # Forward all requests to Node.
    # The port must match what Node listens on internally.

    proxy_pass http://127.0.0.1:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_cache_bypass \$http_upgrade;
  }
}
" | sudo tee /etc/nginx/sites-available/${application_hostname}.conf

# Enable the application.
sudo ln -fs /etc/nginx/sites-available/${application_hostname}.conf /etc/nginx/sites-enabled/
sudo systemctl reload nginx
