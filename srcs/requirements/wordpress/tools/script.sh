#!/bin/sh

set -e

echo "memory_limit = 512M" >> /etc/php83/php.ini

#wait for mariadb to be ready
attempts=0
while ! mariadb -h"$MYSQL_HOST" -u"$WP_DB_USER" -p"$WP_DB_PWD" "$WP_DB_NAME" &>/dev/null; do
 attempts=$((attempts + 1))
 echo "MariaDB unavailable. Attempt $attempts: Retrying in 5  seconds..."
 if [ $attempts -ge 12 ]; then
  echo "Max attempts reached. Could not connect to MariaDB."
  exit 1
 fi
 sleep 5
done
echo "MariaDB connection established!"

# show database
mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PWD $WP_DB_NAME << EOF
SHOW DATABASES;
EOF

# set working directory
cd /var/www/html/

# donload WP CLI
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
chmod +x /usr/local/bin/wp

# download WP core
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
     --dbname="$WP_DB_NAME" \
     --dbuser="$WP_DB_USER" \
     --dbpass="$WP_DB_PWD" \
     --dbhost="$MYSQL_HOST" \
     --path=/var/www/html/ \
     --allow-root

    wp core install \
     --url="$DOMAIN_NAME" \
     --title="$WP_TITLE" \
     --admin_user="$WP_ADMIN_USR" \
     --admin_password="$WP_ADMIN_PWD" \
     --admin_email="$WP_ADMIN_EMAIL" \
     --allow-root
else
    echo "WordPress is already installed, skipping download."
fi

# create wordpress user
if ! wp user get "$WP_USR" --field=user_login --allow-root > /dev/null 2>&1; then
    wp user create \
        "$WP_USR" \
        "$WP_EMAIL" \
        --role=author \
        --user_pass="$WP_PWD" \
        --allow-root
else
    echo "WordPress user '$WP_USR' already exists. Skipping user creation."
fi

#set the theme
wp theme install neve --activate --allow-root

#update plugin
wp plugin update --all --allow-root

wp option update siteurl "https://$DOMAIN_NAME" --allow-root
wp option update home "https://$DOMAIN_NAME" --allow-root

wp rewrite structure '/%postname%' --allow-root
wp rewrite flush --allow-root

chown -R nginx:nginx /var/www/html/
chmod -R 755 /var/www/html/

exec php-fpm83 -F
