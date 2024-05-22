FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY conf/custom.cnf /etc/mysql/mariadb.conf.d/

# copying init.sql
COPY conf/init.sql /etc/mysql/init.sql
COPY tools/docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "mariadbd" ]

# works
# COPY conf/init.sql /etc/mysql/init.sql
# ENTRYPOINT [ "mariadbd" ]

# creating it
# COPY tools/docker-entrypoint.sh /docker-entrypoint.sh
# ENTRYPOINT [ "/docker-entrypoint.sh" ]
# CMD [ "mariadbd" ]

# maintaining alive
# ENTRYPOINT [ "tail", "-f" ]
