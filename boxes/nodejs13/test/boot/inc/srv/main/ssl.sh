#!/bin/bash

# ------------------------------------------------------------------------------
# Generate self-signed SSL certificates.
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
