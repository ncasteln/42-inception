#!/bin/bash

# @param $@ /usr/sbin/php-fpm7.4 --nodaemonize is default argument provided by Dockerfile

WP_PATH='/var/www/html/localhost/public_html/'
WP_SECRETS='/run/secrets/wordpress_secrets'

wp core download --allow-root --path="${WP_PATH}"

# variable are in /run/secrets/wordpress_secrets
WORDPRESS_DB_NAME=$(cat "${WP_SECRETS}" | grep 'WORDPRESS_DB_NAME' | awk -F '=' '{ print $2 }')
WORDPRESS_DB_USER=$(cat "${WP_SECRETS}" | grep 'WORDPRESS_DB_USER' | awk -F '=' '{ print $2 }')
WORDPRESS_DB_PASSWORD=$(cat "${WP_SECRETS}" | grep 'WORDPRESS_DB_PASSWORD' | awk -F '=' '{ print $2 }')
WORDPRESS_DB_HOST=$(cat "${WP_SECRETS}" | grep 'WORDPRESS_DB_HOST' | awk -F '=' '{ print $2 }')

# wp configuration file
wp config create --allow-root \
  --path="$WP_PATH" \
  --dbname="$WORDPRESS_DB_NAME" \
  --dbuser="$WORDPRESS_DB_USER" \
  --dbpass="$WORDPRESS_DB_PASSWORD" \
  --dbhost="$WORDPRESS_DB_HOST"

# redis
#<< EOF \
# define( 'WP_CACHE', true ); \
# define('WP_REDIS_HOST', 'redis'); \
# define('WP_REDIS_PORT', '6379'); \
# EOF

# wp installation
DOMAIN_NAME=$(cat "${WP_SECRETS}" | grep 'DOMAIN_NAME' | awk -F '=' '{ print $2 }')
ADMIN_USER=$(cat "${WP_SECRETS}" | grep 'ADMIN_USER' | awk -F '=' '{ print $2 }')
ADMIN_PASSWORD=$(cat "${WP_SECRETS}" | grep 'ADMIN_PASSWORD' | awk -F '=' '{ print $2 }')
ADMIN_EMAIL=$(cat "${WP_SECRETS}" | grep 'ADMIN_EMAIL' | awk -F '=' '{ print $2 }')

wp core install --allow-root \
  --url="$DOMAIN_NAME" \
  --title='inception' \
  --admin_user="$ADMIN_USER" \
  --admin_password="$ADMIN_PASSWORD" \
  --admin_email="$ADMIN_EMAIL" \
  --path="$WP_PATH" \
  --skip-email

exec $@;
