#!/bin/bash

# ------------------------------------------------------------------------------
# Configure Nginx to serve the main application.
# ------------------------------------------------------------------------------

startNewTask "Configuring Nginx for main application"

sudo touch /etc/nginx/sites-available/${application_hostname}.conf
sudo tee /etc/nginx/sites-available/${application_hostname}.conf << END

server {

  # -- ROUTING: HTTP to HTTPS --------------------------------------------------

  listen 80;
  listen [::]:80;

  server_name ${application_hostname} ${application_alias};

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  return 301 https://\$host\$request_uri;

}

server {

  # -- ROUTING -----------------------------------------------------------------

  listen 443 ssl;
  listen [::]:443 ssl;

  server_name ${application_hostname} ${application_alias};

  # -- LOGGING -----------------------------------------------------------------

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log warn;

  # -- SSL/TLS -----------------------------------------------------------------

  ssl_certificate ${path_to_ssl_crt};
  ssl_certificate_key ${path_to_ssl_key};

  # -- HTTP CONFIGURATION ------------------------------------------------------

  # Disable checking of client request payload size.
  # @see //nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size
  client_max_body_size 0;

  # -- HEADERS -----------------------------------------------------------------

  # Enable HTTP Strict Transport Security. Cache for six months.
  # @see //developer.mozilla.org/en-US/docs/Security/HTTP_Strict_Transport_Security
  add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload;";

  # X-Frame-Options.
  # @see //developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
  add_header X-Frame-Options DENY always;

  # X-Content-Type-Options.
  # @see //developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
  add_header X-Content-Type-Options nosniff always;

  # X-Xss_Protection.
  # @see //developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection
  add_header X-Xss-Protection "1; mode=block" always;

  # Content-Security-Policy.
  # @see //developer.mozilla.org/en/docs/Mozilla/Add-ons/WebExtensions/Content_Security_Policy
  # add_header Content-Security-Policy "default-src 'none'; frame-ancestors 'none'; script-src 'self'; img-src 'self'; style-src 'self'; base-uri 'self'; form-action 'self';";

  # Referrer-Policy.
  # @see //developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy
  add_header Referrer-Policy "no-referrer, strict-origin-when-cross-origin";

  # -- DOCUMENT ROOT -----------------------------------------------------------

  # The `root` directive sets the local filesystem directory from which to serve
  # files. Disable this if you want Nginx to handle every request, including
  # static files.
  root ${application_rootdir};

  # -- STATIC CONTENT ----------------------------------------------------------

  # @todo - All these options are disabled by default, since Nginx is not used
  # to serve any static content except for its error pages. Improve Nginx's
  # caching of "static" content generated dynamically by the backend, origin
  # server - @see //serversforhackers.com/c/nginx-caching

  # Deny requests to all files starting ".ht" in the root directory.
  # location ~ /\.ht {
  #   deny all;
  # }

  # In development, never tell the client to cache CSS, JavaScript, images, etc.
  # location ~* \.(bmp|css|gif|ico|jpeg|jpg|js|png|svg|svgz|webp|woff|woff2)$ {
  #   access_log off;
  #   expires off;
  # }

  # In development, refresh static HTML, JSON and XML files ASAP.
  # location ~* \.(htm|html|json|xml)$ {
  #   expires off;
  # }

  # -- BACKEND PROXY -----------------------------------------------------------

  # For all requests:
  # 1. Try to resolve the path to a real file (this will fail if no "root" dir).
  # 2. Else forward to the Node.js back-end.
  location / {
    try_files \$uri @backend;
  }

  # Forward all other requests to Node.js.
  # The port must match what Node.js listens on internally.
  location @backend {
    proxy_pass http://127.0.0.1:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_cache_bypass \$http_upgrade;
  }

}

END

sudo ln -fs /etc/nginx/sites-available/${application_hostname}.conf /etc/nginx/sites-enabled/

# Test and enable this configuration.
sudo nginx -t
sudo systemctl reload nginx
