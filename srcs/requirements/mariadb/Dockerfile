FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY conf/custom.cnf /etc/mysql/mariadb.conf.d/

#works
COPY conf/init.sql /etc/mysql/init.sql
ENTRYPOINT [ "mariadbd" ]

# why this fucking approach doesnt work properly?
# COPY tools/docker-entrypoint.sh /docker-entrypoint.sh
# ENTRYPOINT [ "/docker-entrypoint.sh" ]
# CMD [ "mariadbd "]

# add later
# COPY tools/healthcheck.sh /healthcheck.sh
