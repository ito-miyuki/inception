#!/bin/sh

openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
 -out /etc/nginx/ssl/nginx.crt \
 -keyout /etc/nginx/ssl/nginx.key \
 -subj "/C=FI/ST=Helsinki/0=42/OU=Student/CN=${DOMAIN_NAME}"
