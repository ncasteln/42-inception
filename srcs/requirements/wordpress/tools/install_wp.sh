#!/bin/bash

WP_PATH='/var/www/html/mysite/public_html/'

# basic dependencies
apt-get install wget -y
apt-get install php7.4-fpm -y

# download wp_cli and set it to be used smartly
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# set the root folder for the website & download WP there
mkdir -p $WP_PATH
chown -R root:root $WP_PATH
wp core download --allow-root --path="${WP_PATH}"

# from those step a database is needed
# install a fake db to make run the installation
# apt-get install mariadb-server -y
# service mariadb start;
# sleep 3;
# mysql -u root -p -e <<MYSQL_SCRIPT
# CREATE DATABASE IF NOT EXISTS mydatabase;
# CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypassword';
# GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# MYSQL_SCRIPT

# required
apt-get install php-mysql -y

# wp-config.php creation
# wp config create --allow-root \
# 	--dbname='mydatabase' \
# 	--dbuser='myuser' \
# 	--dbpass='mypassword' \
# 	--dbhost='localhost' \
# 	--dbprefix='wp_' \
# 	--path="${WP_PATH}/"

# wp core install --allow-root