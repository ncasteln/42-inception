#!/bin/bash

# mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
# mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mariadb -e "FLUSH PRIVILEGES;"

rm -rfd /var/lib/mysql;
mariadb-install-db;

mariadbd-safe;

mariadb -e "CREATE DATABASE IF NOT EXISTS \`helloworld\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`helloworld\`@'localhost' IDENTIFIED BY 'helloworld';"
mariadb -e "GRANT ALL PRIVILEGES ON \`helloworld\`.* TO \`helloworld\`@'%' IDENTIFIED BY 'helloworld';"
mariadb -e "FLUSH PRIVILEGES;"
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'helloworld';"

