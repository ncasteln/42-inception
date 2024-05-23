#!/bin/bash

# required by php
mkdir -p /var/run/php/php-fpm
touch /var/run/php/php-fpm/php7.4-fpm.pid

# wordpress CLI install
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# give ownership to www-data
mkdir -p /var/www/html/localhost/public_html
chown -R www-data:www-data /var/www/html/localhost/public_html
chown -R www-data:www-data /var/www/
