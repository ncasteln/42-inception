FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# wp-config.php
# COPY conf/wp-config.php /var/www/html/ncasteln.42.fr/public_html/

# needed by custom-www.conf file
# RUN groupadd myuser
# RUN useradd -g myuser myuser


# copy configurationfile ?
# COPY conf/wp-config.php /var/www/html/localhost/public_html/

# copy custom-www.conf
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

# requested in the original /etc/php/7.4/fpm/php-fpm.conf file
RUN mkdir -p /var/run/php/php-fpm
RUN touch /var/run/php/php-fpm/php7.4-fpm.pid

# install wp
COPY tools/install_wp.sh /install_wp.sh
ENTRYPOINT [ "/install_wp.sh" ]

WORKDIR /var/www/html

# CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ]

# PROBLEM:
# using RUN the script didn't work properly
# solution - 1
# put /usr/sbin/php-fpm7.4 --nodaemonize; in the script
#
# solution - 2
# use ENTRYPOINT [ "/install_wp.sh" ] but it creates a loop which has to be stopped
# and use CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ] to start the daemon
#
# TRY to put the if and the command php-fpm indise
#