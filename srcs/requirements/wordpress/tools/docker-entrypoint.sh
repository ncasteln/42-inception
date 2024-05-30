#!/bin/bash

# user logged is www-data
# @param $@ /usr/sbin/php-fpm7.4 --nodaemonize is default argument provided by Dockerfile

P="\033[0;35m"
W="\033[0m"
WP_PATH="/var/www/html/${WP_DOMAIN}/public_html"

if wp core is-installed --path="$WP_PATH" > /dev/null 2>&1; then
  echo -e "${P}*** [INCEPTION] Wordpress already installed ***${W}";
  exec $@;
fi

echo -e "${P}*** [INCEPTION] Installing wordpress ***${W}"
wp core download --path="$WP_PATH"

# variable are in /run/secrets/wordpress_secrets
DB_NAME=$(cat "${WP_SECRETS}" | grep 'DB_NAME' | awk -F '=' '{ print $2 }')
DB_USER=$(cat "${WP_SECRETS}" | grep 'DB_USER' | awk -F '=' '{ print $2 }')
DB_PASSWORD=$(cat "${WP_SECRETS}" | grep 'DB_PASSWORD' | awk -F '=' '{ print $2 }')
DB_HOST=$(cat "${WP_SECRETS}" | grep 'DB_HOST' | awk -F '=' '{ print $2 }')

# wp configuration file
wp config create --path="$WP_PATH" \
  --dbname="$DB_NAME" \
  --dbuser="$DB_USER" \
  --dbpass="$DB_PASSWORD" \
  --dbhost="$DB_HOST"

# wp installation
ADMIN_USER=$(cat "${WP_SECRETS}" | grep 'ADMIN_USER' | awk -F '=' '{ print $2 }')
ADMIN_PASSWORD=$(cat "${WP_SECRETS}" | grep 'ADMIN_PASSWORD' | awk -F '=' '{ print $2 }')
ADMIN_EMAIL=$(cat "${WP_SECRETS}" | grep 'ADMIN_EMAIL' | awk -F '=' '{ print $2 }')

wp core install --url="$WP_DOMAIN" \
  --title='inception' \
  --admin_user="$ADMIN_USER" \
  --admin_password="$ADMIN_PASSWORD" \
  --admin_email="$ADMIN_EMAIL" \
  --path="$WP_PATH" \
  --skip-email

exec $@;
