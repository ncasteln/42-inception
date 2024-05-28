#!/bin/bash

# useful commands to check database contents:
# mariadb -uroot -pmyrootpassword  -e "SELECT User, Host FROM mysql.user;"

MARIADB_SECRETS='/run/secrets/mariadb_secrets'

MARIADB_DATABASE=$(cat "${MARIADB_SECRETS}" | grep 'MARIADB_DATABASE' | awk -F '=' '{ print $2 }')
MARIADB_USER=$(cat "${MARIADB_SECRETS}" | grep 'MARIADB_USER' | awk -F '=' '{ print $2 }')
MARIADB_PASSWORD=$(cat "${MARIADB_SECRETS}" | grep 'MARIADB_PASSWORD' | awk -F '=' '{ print $2 }')
MARIADB_ROOT_PASSWORD=$(cat "${MARIADB_SECRETS}" | grep 'MARIADB_ROOT_PASSWORD' | awk -F '=' '{ print $2 }')

echo "CREATE DATABASE "${MARIADB_DATABASE}";
CREATE USER '"${MARIADB_USER}"'@'wordpress.inception_backend' IDENTIFIED BY '"${MARIADB_PASSWORD}"';
GRANT ALL PRIVILEGES ON "${MARIADB_DATABASE}".* TO '"${MARIADB_USER}"'@'wordpress.inception_backend' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '"${MARIADB_ROOT_PASSWORD}"';
FLUSH PRIVILEGES;" > /etc/mysql/init.sql

exec $@;
