#!/bin/sh

set -e

#wait for mariadb to be ready
attempts=0
while ! mariadb -h"$MYSQL_HOST" -u"$WP_DB_USER" -p"$WP_DB_PWD" "$WP_DB_NAME" &>dev/null; do
 attempts=$((attempts + 1))
 echo "MariaDB unavailable. Attempt $attempts: Retrying in 5  seconds..."
 if [ $attempts -ge 12]; then
  echo "Max attempts reached. Could not connect to MariaDB."
  exit 1
 fi
 sleep 5
done
echo "MariaDB connection established!"

if [ ! -f /var/www/html/wp-config.php ]; then
 echo "Creating wp-config.php..."
 wp config create \
  --dbname="$WP_DB_NAME" \
  --dbuser="$WP_DB_USER" \
  --dbpass="$WP_DB_PWD" \
  --dbhost="$MYSQL_HOST" \
  --path=/var/www/html/ \
  --allow-root
fi

if ! wp core is-installed --allow-root; then
 echo "Installing WordPress
 wp core install \
  --url="https://$DOMAIN_NAME" \
  --title="$WP_TITLE" \
  --admin_user="$WP_ADMIN_PWD" \
  --admin_password="$WP_ADMIN_PWD" \
  --admin_email="$WP_ADMIN_EMAIL" \
  --allow-root

#create user
 wp user create \
 "$WP_USR" \
 "$WP_EMAIL" \
 --role=author \
 --user_pass="$WP_PWD"
 --allow-root

# set the theme
 wp theme install neve --active --allow-root

 wp plugin update --all --allow-root

 wp option update siteurl "https://$DOMAIN_NAME" --allow-root
 wp option update home "https://$DOMAIN_NAME" --allow-root
fi

chmod -R nginx:nginx /var/www/html/
chmod -R 755 /var/www/html/

exec php-fpm81 --nodaemonize

