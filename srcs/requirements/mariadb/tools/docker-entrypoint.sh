#!/bin/bash

# useful commands to check database contents:
# mariadb -uroot -pmyrootpassword  -e "SELECT User, Host FROM mysql.user;"

P="\033[0;35m"
W="\033[0m"

if [ -d /var/lib/mysql/wp_database ]; then
    echo -e "${P}*** [INCEPTION] Wordpress database already initialized ***${W}";
else
    echo -e "${P}*** [INCEPTION] Initializing Wordpress database and required user ***${W}";

    # MARIADB_SECRETS='/run/secrets/mariadb_secrets'

    DB_NAME=$(cat "${MARIADB_SECRETS}" | grep 'DB_NAME' | awk -F '=' '{ print $2 }')
    DB_USER=$(cat "${MARIADB_SECRETS}" | grep 'DB_USER' | awk -F '=' '{ print $2 }')
    DB_PASSWORD=$(cat "${MARIADB_SECRETS}" | grep 'DB_PASSWORD' | awk -F '=' '{ print $2 }')
    DB_ROOT_PASSWORD=$(cat "${MARIADB_SECRETS}" | grep 'DB_ROOT_PASSWORD' | awk -F '=' '{ print $2 }')

    echo "CREATE DATABASE "${DB_NAME}";
    CREATE USER '"${DB_USER}"'@'wordpress.inception_backend' IDENTIFIED BY '"${DB_PASSWORD}"';
    GRANT ALL PRIVILEGES ON "${DB_NAME}".* TO '"${DB_USER}"'@'wordpress.inception_backend' WITH GRANT OPTION;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '"${DB_ROOT_PASSWORD}"';
    FLUSH PRIVILEGES;" > /var/lib/mysql/init.sql
fi

exec $@;
