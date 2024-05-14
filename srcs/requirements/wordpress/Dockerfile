FROM debian:bullseye

# wordpress pre-config
COPY tools/configure.sh /configure.sh
RUN /configure.sh

# php configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

# wordpress installer
COPY tools/docker-entrypoint.sh /docker-entrypoint.sh

# entrypoint
WORKDIR /var/www/html
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ]
