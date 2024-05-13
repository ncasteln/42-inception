#!/bin/bash

# $@ /usr/sbin/php-fpm7.4 --nodaemonize is default argument provided by Dockerfile

WP_PATH='/var/www/html/localhost/public_html/'

wp core download --allow-root --path="${WP_PATH}"

# wp configuration file
wp config create --allow-root \
  --path="${WP_PATH}" \
  --dbname="${WORDPRESS_DB_NAME}" \
  --dbuser="${WORDPRESS_DB_USER}" \
  --dbpass="${WORDPRESS_DB_PASSWORD}" \
  --dbhost="${WORDPRESS_DB_HOST}"

wp core install --allow-root \
  --url='localhost' \
  --title=localhost \
  --admin_user=admin \
  --admin_password=admin \
  --admin_email=admin@admin.admin \
  --path="${WP_PATH}" \
  --skip-email

exec $@;
