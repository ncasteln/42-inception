#!/bin/bash

mkdir -p ./secrets/mariadb ./secrets/wordpress;

echo -e "\
DB_USER=\n\
DB_PASSWORD=\n\
DB_NAME=wp_\n\
DB_ROOT_PASSWORD=\n" > ./secrets/mariadb/.env;

echo -e "\
DB_USER=\n\
DB_PASSWORD=\n\
DB_NAME=wp_\n\
DB_HOST=mariadb:3306\n\
ADMIN_USER=\n\
ADMIN_PASSWORD=\n\
ADMIN_EMAIL=\n" > ./secrets/wordpress/.env;
