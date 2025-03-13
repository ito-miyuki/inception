#!/bin/sh

set -e

echo "Setting correct permissions for /var/www/html..."

chown -R nginx:nginx /var/www/html
chmod -R 755 /var/www/html

echo "Starting Nginx..."
exec nginx -g "daemon off;"
