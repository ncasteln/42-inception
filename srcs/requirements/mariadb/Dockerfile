FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
    mariadb-server

COPY conf/custom.cnf /etc/mysql/mariadb.conf.d/

COPY tools/docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "mariadbd" ]
