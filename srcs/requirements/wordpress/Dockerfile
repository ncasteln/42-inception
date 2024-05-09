FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# wp-config.php
# COPY conf/wp-config.php /var/www/html/ncasteln.42.fr/public_html/

# install wp
COPY tools/install_wp.sh /install_wp.sh
RUN ./install_wp.sh

# needed by custom-www.conf file
# RUN groupadd wordpress_user
# RUN useradd -g wordpress_user wordpress_user

# copy custom-www.conf
# COPY conf/custom-www.conf /etc/php/7.4/fpm/pool.d/

# requested in the original /etc/php/7.4/fpm/php-fpm.conf file
RUN mkdir -p /var/run/php/php-fpm
RUN touch /var/run/php/php-fpm/php7.4-fpm.pid

ENTRYPOINT [ "php-fpm7.4", "--nodaemonize" ]