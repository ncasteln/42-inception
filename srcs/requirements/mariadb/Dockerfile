FROM debian:bullseye

RUN apt-get update -y && apt-get install -y mariadb-server

COPY conf/custom.cnf /etc/mysql/mariadb.conf.d/

# using docker-entrypoint which creates the file
COPY tools/docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "mariadbd" ]

# works
# COPY conf/init.sql /etc/mysql/init.sql
# ENTRYPOINT [ "mariadbd" ]
