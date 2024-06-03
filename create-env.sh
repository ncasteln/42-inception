#!/bin/bash

G="\033[0;32m";
R="\033[0;31m"
W="\033[0m";

echo -e "${G}* Shared variables${W}";

while [ -z "$DB_USER" ]
do read -p "Username: " DB_USER; done;

while [ -z $DB_PASSWORD ]
do read -p "Password: " DB_PASSWORD; done;

while [ -z $DB_NAME ]
do read -p "Database name: wp_" DB_NAME; done;

echo -e "${G}* Mariadb only variables${W}";

while [ -z $DB_ROOT_PASSWORD ]
do read -p "Root password: " DB_ROOT_PASSWORD; done;

echo -e "${G}* Wordpress only variables${W}";

while true
do
    read -p "Admin user: " ADMIN_USER;
    UPPERCASE=$(echo "$ADMIN_USER" | tr '[:lower:]' '[:upper:]');
    if [ -z $UPPERCASE ]; then
        continue;
    fi
    if [[ "$UPPERCASE" == *"ADMIN"* ]]; then
        echo -e "${R}Admin username and password cannot contain 'admin' or other similar${W}";
        continue;
    else
        break;
    fi
done;

while true
do
    read -p "Admin password: " ADMIN_PASSWORD;
    UPPERCASE=$(echo "$ADMIN_PASSWORD" | tr '[:lower:]' '[:upper:]');
    if [ -z $UPPERCASE ]; then
        continue;
    fi
    if [[ "$UPPERCASE" == *"ADMIN"* ]]; then
        echo -e "${R}Admin username and password cannot contain 'admin' or other similar${W}";
        continue;
    else
        break;
    fi
done;

MARIADB_SECRET_FOLDER=./secrets/mariadb
WORDPRESS_SECRET_FOLDER=./secrets/wordpress
mkdir -p "$MARIADB_SECRET_FOLDER" "$WORDPRESS_SECRET_FOLDER"

echo -e "\
DB_USER=$DB_USER\n\
DB_PASSWORD=$DB_PASSWORD\n\
DB_NAME=wp_$DB_NAME\n\
DB_ROOT_PASSWORD=$DB_ROOT_PASSWORD\n" > $MARIADB_SECRET_FOLDER/.env;

echo -e "\
DB_USER=$DB_USER\n\
DB_PASSWORD=$DB_PASSWORD\n\
DB_NAME=wp_$DB_NAME\n\
DB_HOST=mariadb:3306\n\
ADMIN_USER=$ADMIN_USER\n\
ADMIN_PASSWORD=$ADMIN_PASSWORD\n\
ADMIN_EMAIL=$ADMIN_USER@my-company.com" > $WORDPRESS_SECRET_FOLDER/.env;
