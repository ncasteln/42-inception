#!/bin/bash

echo "I ran here"
# basic dependencies
apt-get install wget -y
apt-get install php-fpm -y # also php7.4?
apt-get install php-mysqli -y

# download wp_cli and set it to be used smartly
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# set the root folder for the website & download WP there
mkdir -p /var/www/html/ncasteln.42.fr/public_html/
chown -R root:root /var/www/ # html/ncasteln.42.fr/public_html/
cd /var/www/html/ncasteln.42.fr/public_html/ && wp core download --allow-root #--path=/var/www/html/ncasteln.42.fr/public_html/

# from those step a database is needed
# wp-config.php creation
# cd /var/www/html/ncasteln.42.fr/public_html/ && wp config create --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --dbhost="${WORDPRESS_DB_HOST}" --path=/var/www/html/ncasteln.42.fr/public_html/ --allow-root
# cd /var/www/html/ncasteln.42.fr/public_html/ && wp config create --allow-root \
# 	--dbname="${WORDPRESS_DB_NAME}" \
# 	--dbuser="${WORDPRESS_DB_USER}" \
# 	--dbpass="${WORDPRESS_DB_PASSWORD}" \
# 	--dbhost="${WORDPRESS_DB_HOST}" \
# 	--path=/var/www/html/ncasteln.42.fr/public_html/

# cd /var/www/html/ncasteln.42.fr/public_html/ && wp core install --allow-root --url=https://localhost --title=localhost --admin_user=admin --admin_password=admin --admin_email=admin@admin.admin --path='/var/www/html/ncasteln.42.fr/public_html/'
# cd /var/www/html/ncasteln.42.fr/public_html/ && wp core install --allow-root \
# 	--url=localhost \
# 	--title=localhost \
# 	--admin_user=admin \
# 	--admin_password=admin \
# 	--admin_email=admin@admin.admin \
# 	--path='/var/www/html/ncasteln.42.fr/public_html/'

# doesnt wait for mariadb how can do it ?
# https://github.com/MariaDB/mariadb-docker/blob/master/healthcheck.sh
