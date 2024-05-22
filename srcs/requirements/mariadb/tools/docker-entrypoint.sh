#!/bin/bash

# ----------------------------------------------------
# rm -rfd /var/lib/mysql;
# mkdir /var/lib/mysql;
# chown -R mysql:mysql /var/lib/mysql;

# chown -R mysql:mysql /etc/mysql/init.sql;
# mariadbd --bootstrap '/etc/mysql/init.sql'; # check logs at cat /var/lib/mysql/mariadb.err
# tail -f;

# To start mariadbd at boot time you have to copy
# support-files/mariadb.service to the right place for your system

# Two all-privilege accounts were created.
# One is root@localhost, it has no password, but you need to
# be system 'root' user to connect. Use, for example, sudo mysql
# The second is mysql@localhost, it has no password either, but
# you need to be the system 'mysql' user to connect.
# After connecting you can set the password, if you would need to be
# able to connect as any of these users with a password and without sudo

# See the MariaDB Knowledgebase at https://mariadb.com/kb

# You can start the MariaDB daemon with:
# cd '/usr' ; /usr/bin/mariadb-safe --datadir='/var/lib/mysql'

# You can test the MariaDB daemon with mysql-test-run.pl
# cd '/usr/share/mysql/mysql-test' ; perl mariadb-test-run.pl

# Please report any problems at https://mariadb.org/jira

# The latest information about MariaDB is available at https://mariadb.org/.

# Consider joining MariaDB's strong and vibrant community:
# https://mariadb.org/get-involved/

# ----------------------------------------------------
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

exec $@;
