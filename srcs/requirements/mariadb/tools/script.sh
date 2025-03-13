#!/bin/sh

mkdir -p /var/lib/mysql /var/run/mysqld /var/log/mysql
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/lib/mysql

# init mariadb data directory
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

echo "Initializing MariaDB database..."

# start mariadb temporary in bootstrap mode to set up initial users and databases
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

# remove anonymous users for security
DELETE FROM mysql.user WHERE User='';

# remove test database as it's not needed
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';

# restrict root access to localhost for security
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

#Set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

#Create WordPress database
CREATE DATABASE $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;

#Create WordPress user
CREATE USER '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PWD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';
GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PWD' WITH GRANT OPTION;

# allow the worspress user to read system tables
GRANT SELECT ON mysql.* TO '$WP_DB_USER'@'%';

# apply changes
FLUSH PRIVILEGES;
EOF

echo "MariaDB initialization complete. Starting MariaDB..."
exec mysqld --defaults-file=/etc/my.cnf.d/mariadb-server.cnf
