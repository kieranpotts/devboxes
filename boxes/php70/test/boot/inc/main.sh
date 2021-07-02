#!/bin/bash

# ------------------------------------------------------------------------------
# Configure Nginx to serve the main hosted application.
#
# To test for syntax errors in Nginx's configuration:
#
#   $ sudo nginx -t
# ------------------------------------------------------------------------------

startNewTask "Generating self-signed SSL certificates"

application_ssl_cnf_path="/etc/ssl/certs/${application_hostname}.cnf"
application_ssl_key_path="/etc/ssl/certs/${application_hostname}.key"
application_ssl_csr_path="/etc/ssl/certs/${application_hostname}.csr"
application_ssl_crt_path="/etc/ssl/certs/${application_hostname}.crt"

# Self-signed wildcard SSL
# certificate configuration.
echo "
[ req ]
default_bits       = 4096
default_md         = sha512
prompt             = no
encrypt_key        = no
distinguished_name = dn
req_extensions     = ext

[ dn ]
countryName            = "ME"
localityName           = "Bywater"                 # L=
organizationName       = "The Green Dragon"        # O=
organizationalUnitName = "Kitchen"                 # OU=
commonName             = "${application_hostname}" # CN=

[ ext ]
# Extensions to add to the certificate request.
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
# subjectAltName = @alt_names

# [alt_names]
# DNS.1 = ${application_alias}
" | sudo tee ${application_ssl_cnf_path}

# Generate key.
sudo su -c "openssl genrsa -out ${application_ssl_key_path} 2048"

# Create the certificate signing request (CSR).
sudo su -c "openssl req -new -out ${application_ssl_csr_path} \
  -key ${application_ssl_key_path} \
  -config ${application_ssl_cnf_path}"

# Sign the SSL certificate.
sudo su -c "openssl x509 -req -days 3650 -in ${application_ssl_csr_path} \
  -signkey ${application_ssl_key_path} \
  -out ${application_ssl_crt_path} \
  -extensions ext -extfile ${application_ssl_cnf_path}"

startNewTask "Configuring Nginx to serve the application"

# Application server configuration.
echo "
server {
  listen 80;
  listen [::]:80;

  # php70.devbox.local
  server_name ${application_hostname} ${application_alias};

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  # Redirect all non-SSL requests to SSL.
  return 301 https://\$host\$request_uri;
}

server {
  listen 443;
  listen [::]:443;

  # php70.devbox.local
  server_name ${application_hostname} ${application_alias};

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  ssl on;
  ssl_certificate ${application_ssl_crt_path};
  ssl_certificate_key ${application_ssl_key_path};

  root ${application_server_rootdir};
  index index.php;

  location / {

    # If the inbound URL does not map to an actual file or directory,
    # redirect the request to the URL rewriting rules.
    try_files \$uri @rewrite;

  }

  location @rewrite {
    try_files \$uri \$uri/ /index.php?\$args;
  }

  location ~ \.php\$ {
    fastcgi_split_path_info ^(.+\.php)(/.+)\$;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME \$request_filename;
    fastcgi_intercept_errors on;
    fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    fastcgi_read_timeout 360;
  }

}
" | sudo tee /etc/nginx/sites-available/${application_hostname}.conf

# The application directory needs to be owned by the `www-data`
# user and `www-data` group, and both user and group should have read
# and write permissions, while the user should have execute permission.
#
# `www-data` is the user under which both Nginx and Apache processes
# run. Any other users who are members of the `www-data` will also be
# able to modify files here. However, if new files are created in this
# directory by another user, you must run:
# `sudo chown -R www-data:www-data /vagrant/path/to/app/root`.

sudo mkdir -p ${application_server_rootdir}
sudo chown -R www-data:www-data ${application_server_rootdir}
sudo chmod -R g+rwX ${application_server_rootdir}

# Enable the application.
sudo ln -fs /etc/nginx/sites-available/${application_hostname}.conf /etc/nginx/sites-enabled/
sudo systemctl reload nginx
