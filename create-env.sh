#!/bin/bash

mkdir -p ./secrets/mariadb ./secrets/wordpress;

echo -e "\
DB_USER=\n\
DB_PASSWORD=\n\
DB_NAME=\n\
DB_ROOT_PASSWORD=\n" > ./secrets/mariadb/.env;

echo -e "\
DB_USER=\n\
DB_PASSWORD=\n\
DB_NAME=\n\
DB_HOST=\n\
ADMIN_USER=\n\
ADMIN_PASSWORD=\n\
ADMIN_EMAIL=\n" > ./secrets/wordpress/.env;
