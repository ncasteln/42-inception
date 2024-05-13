FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/custom.cnf /etc/mysql/mariadb.conf.d/

# copy file to initialize a custom database (init_file)
# necessary to start the service alternative to mariadb_install_tables or something similar
COPY conf/init.sql /etc/mysql/init.sql

# COPY tools/init_mariadb.sh /init_mariadb.sh
# RUN ./init_mariadb.sh

# ENTRYPOINT [ "mysqld_safe" ]
# ENTRYPOINT [ "mariadbd-safe" ]
ENTRYPOINT [ "mariadbd" ]
