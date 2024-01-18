#!/bin/bash

# ------------------------------------------------------------------------------
# Generate self-signed SSL certificates.
# ------------------------------------------------------------------------------

startNewTask "Generating self-signed SSL certificates"

path_to_ssl_cnf="/etc/ssl/certs/${sslcert_file_name}.cnf"
path_to_ssl_key="/etc/ssl/certs/${sslcert_file_name}.key"
path_to_ssl_csr="/etc/ssl/certs/${sslcert_file_name}.csr"
path_to_ssl_crt="/etc/ssl/certs/${sslcert_file_name}.crt"

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
commonName             = "${sslcert_common_name}"  # CN=

[ ext ]
# Extensions to add to the certificate request.
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.0 = ${sslcert_common_name}
DNS.1 = ${sslcert_alt_name_1}
DNS.2 = ${sslcert_alt_name_2}
DNS.3 = ${sslcert_alt_name_3}
" | sudo tee ${path_to_ssl_cnf}

# Generate key.
sudo su -c "openssl genrsa -out ${path_to_ssl_key} 2048"

# Create the certificate signing request (CSR).
sudo su -c "openssl req -new -out ${path_to_ssl_csr} \
  -key ${path_to_ssl_key} \
  -config ${path_to_ssl_cnf}" # &> /dev/null # A bit noisy!

# Sign the SSL certificate.
sudo su -c "openssl x509 -req -days 3650 -in ${path_to_ssl_csr} \
  -signkey ${path_to_ssl_key} \
  -out ${path_to_ssl_crt} \
  -extensions ext -extfile ${path_to_ssl_cnf}" # &> /dev/null # A bit noisy!
