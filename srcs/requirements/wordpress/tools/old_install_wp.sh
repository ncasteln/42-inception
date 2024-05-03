#!/bin/bash

WP_DIR=/var/www/

# https://developer.wordpress.org/advanced-administration/before-install/

# TO DO: separate the installation ?
wget https://wordpress.org/latest.tar.gz --directory-prefix="${WP_DIR}"

cd $WP_DIR && tar --extract --gzip --verbose --file latest.tar.gz
cd $WP_DIR && rm -rf latest.tar.gz
chown -R root:root /var/www/wordpress