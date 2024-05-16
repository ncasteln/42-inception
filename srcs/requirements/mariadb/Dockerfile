FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

COPY conf/custom.cnf /etc/mysql/mariadb.conf.d/

# copy file to initialize a custom database (init_file)
# necessary to start the service alternative to mariadb_install_tables or something similar
# COPY conf/init.sql /etc/mysql/init.sql
# RUN chown root:root /etc/mysql/init.sql

COPY tools/docker-entrypoint.sh /docker-entrypoint.sh
RUN /docker-entrypoint.sh

# COPY tools/healthcheck.sh /healthcheck.sh

ENTRYPOINT [ "mariadbd" ]

# PROBLEM
# How can i have an .sql file which contains variables?
# If i try another approach by using scripts, how can i add database before starting, like the init_file does?
# Is it ok to have /run/secrets/something which is pretty readable from outside? How can avoid it ?


# https://stackoverflow.com/questions/48044904/docker-mariadb-doesnt-start-at-init-based-in-debianstable
