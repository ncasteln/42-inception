#!/bin/bash

# chown -R mysql:mysql /var/lib/mysql;

# service mariadb start;

# mariadb -e "CREATE DATABASE IF NOT EXISTS \`PorcoDio\`;"\
# mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# mariadb -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# mariadb -e "FLUSH PRIVILEGES;"