#!/bin/sh

mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/lib/mysql

mariadb_install_db --user=mysql --datadir=/var/lib/mysql

mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

# for security reason
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN('localhost');

# set up the password for root account
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

# creating wordpress database and user is missing at this moment

FLUSH PRIVILEGES;
EOF

# exec mysqld_safe --defaults-file=/etc/my.cnf.d/mariadb-server.cnf
exec mysqld --datadir=/var/lib/mysql --user=mysql --socket=/run/mysqld/mysqld.sock
