#!/bin/bash

P="\033[0;35m"
W="\033[0m"
DB_NAME=$(cat "${DB_SECRETS}" | grep 'DB_NAME' | awk -F '=' '{ print $2 }')

if [ -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo -e "${P}*** [INCEPTION] Wordpress database already initialized ***${W}";
else
    echo -e "${P}*** [INCEPTION] Initializing Wordpress database and required user ***${W}";

    DB_NAME=$(cat "${DB_SECRETS}" | grep 'DB_NAME' | awk -F '=' '{ print $2 }')
    DB_USER=$(cat "${DB_SECRETS}" | grep 'DB_USER' | awk -F '=' '{ print $2 }')
    DB_PASSWORD=$(cat "${DB_SECRETS}" | grep 'DB_PASSWORD' | awk -F '=' '{ print $2 }')
    DB_ROOT_PASSWORD=$(cat "${DB_SECRETS}" | grep 'DB_ROOT_PASSWORD' | awk -F '=' '{ print $2 }')

    echo "CREATE DATABASE "${DB_NAME}";
    CREATE USER '"${DB_USER}"'@'wordpress.inception_backend' IDENTIFIED BY '"${DB_PASSWORD}"';
    GRANT ALL PRIVILEGES ON "${DB_NAME}".* TO '"${DB_USER}"'@'wordpress.inception_backend' WITH GRANT OPTION;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '"${DB_ROOT_PASSWORD}"';
    FLUSH PRIVILEGES;" > /var/lib/mysql/init.sql
fi

exec $@;
