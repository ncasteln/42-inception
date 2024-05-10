#!/bin/bash

# basic dependencies
apt-get install wget -y
apt-get install php-fpm -y # also php7.4?
apt-get install php-mysqli -y

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/html/localhost/public_html
chown -R www-data:www-data /var/www/html/localhost/public_html
chown -R www-data:www-data /var/www/
cd /var/www/html/localhost/public_html/
wp core download --allow-root

# wp configuration file
wp config create --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --dbhost="${WORDPRESS_DB_HOST}" --allow-root
wp core install --allow-root --url='localhost' --title=localhost --admin_user=admin --admin_password=admin --admin_email=admin@admin.admin --skip-email

/usr/sbin/php-fpm7.4 --nodaemonize;

# OLD
# download wp_cli and set it to be used smartly
# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# mv wp-cli.phar /usr/local/bin/wp

# # create folder and set the root privileges
# mkdir -p /var/www/html/localhost/public_html/
# chown -R root:root /var/www/ # html/localhost/public_html/

# # download and install
# cd /var/www/html/localhost/public_html/
# wp core download --allow-root

# from those step a database is needed
# wp-config.php creation
# wp config create --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --dbhost="${WORDPRESS_DB_HOST}" --allow-root
# wp config create --allow-root \
# 	--dbname="${WORDPRESS_DB_NAME}" \
# 	--dbuser="${WORDPRESS_DB_USER}" \
# 	--dbpass="${WORDPRESS_DB_PASSWORD}" \
# 	--dbhost="${WORDPRESS_DB_HOST}" \
# 	--path=/var/www/html/localhost/public_html/

# wp core install --allow-root --url=https://localhost --title=localhost --admin_user=admin --admin_password=admin --admin_email=admin@admin.admin
# wp core install --allow-root \
# 	--url=localhost \
# 	--title=localhost \
# 	--admin_user=admin \
# 	--admin_password=admin \
# 	--admin_email=admin@admin.admin \
# 	--path='/var/www/html/localhost/public_html/'

# doesnt wait for mariadb how can do it ?
# https://github.com/MariaDB/mariadb-docker/blob/master/healthcheck.sh
