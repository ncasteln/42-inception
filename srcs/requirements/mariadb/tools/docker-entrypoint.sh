#!/bin/bash

# rm -rfd /var/lib/mysql;
# mariadb-install-db;

# /etc/init.d/mariadb start

MARIADB_SECRETS='/run/secrets/mariadb_secrets'

MYSQL_DATABASE=$(cat "${MARIADB_SECRETS}" | grep 'MYSQL_DATABASE' | awk -F '=' '{ print $2 }')
MYSQL_USER=$(cat "${MARIADB_SECRETS}" | grep 'MYSQL_USER' | awk -F '=' '{ print $2 }')
MYSQL_PASSWORD=$(cat "${MARIADB_SECRETS}" | grep 'MYSQL_PASSWORD' | awk -F '=' '{ print $2 }')
MYSQL_ROOT_PASSWORD=$(cat "${MARIADB_SECRETS}" | grep 'MYSQL_ROOT_PASSWORD' | awk -F '=' '{ print $2 }')

echo "CREATE DATABASE "${MYSQL_DATABASE}";
CREATE USER '"${MYSQL_USER}"'@'%' IDENTIFIED BY '"${MYSQL_PASSWORD}"';
GRANT ALL PRIVILEGES ON *.* TO '"${MYSQL_USER}"'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '"${MYSQL_ROOT_PASSWORD}"';
FLUSH PRIVILEGES;" > /etc/mysql/init.sql

# chown mysql:mysql /etc/mysql/init.sql
# chmod 400 /etc/mysql/init.sql

# mariadbd;

exec $@;
