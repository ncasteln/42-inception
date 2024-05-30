FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
    wget \
    php-fpm \
    php-mysqli

COPY tools/pre-configure.sh /pre-configure.sh
RUN /pre-configure.sh

# php configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

# wordpress installer
COPY tools/docker-entrypoint.sh /docker-entrypoint.sh

# entrypoint
USER www-data
WORKDIR /var/www/html
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ]
