#!/bin/bash

# rm -rfd /var/lib/mysql;
# mariadb-install-db;

# /etc/init.d/mariadb start
# mariadbd-safe;

echo "CREATE DATABASE ${MYSQL_DATABASE};
CREATE USER '"${MYSQL_USER}"'@'%' IDENTIFIED BY '"${MYSQL_PASSWORD}"';
GRANT ALL PRIVILEGES ON *.* TO '"${MYSQL_USER}"'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '"${MYSQL_ROOT_PASSWORD}"';
FLUSH PRIVILEGES;" > /etc/mysql/init.sql

# chown mysql:mysql /etc/mysql/init.sql
# chmod 400 /etc/mysql/init.sql

# mariadbd;
