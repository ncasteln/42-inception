#!/bin/bash

apt-get install openssl -y

openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-subj "/C=DE/ST=Stuttgart/O=my-company/CN=localhost" \
	-newkey rsa:2048 \
	-keyout "/etc/ssl/private/localhost.key" \
	-out "/etc/ssl/certs/localhost.crt";

# -x509:	used to generate a nginx cert for test pourposes (self-signed)
# -nodes:	not encrypt private key
# -days:	time of validity
# -subj:	params "/C=country/ST=state/O=company/CN=sitename" \
# -newkey
# -keyout	path where key is stored
# -out		path where the cert is stored