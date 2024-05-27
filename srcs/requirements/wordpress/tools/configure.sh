#!/bin/bash

# required by php
mkdir -p /var/run/php/php-fpm
touch /run/php/php-fpm/php7.4-fpm.pid
chown -R www-data:www-data /run/php/

# wordpress CLI install
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# give ownership to www-data
mkdir -p /var/www/html/localhost/public_html
chown -R www-data:www-data /var/log/
chown -R www-data:www-data /var/www/html/localhost/public_html # rremoveeeee ----- !
chown -R www-data:www-data /var/www/

# check
# /var/log OK
# /etc/php/7.4/fpm
# /run/php