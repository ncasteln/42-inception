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
  --url="${DOMAIN_NAME}" \
  --title='inception' \
  --admin_user="${ADMIN_USER}" \
  --admin_password="${ADMIN_PASSWORD}" \
  --admin_email="${ADMIN_EMAIL}" \
  --path="${WP_PATH}" \
  --skip-email

exec $@;
