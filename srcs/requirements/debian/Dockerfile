FROM debian:bullseye

# installation
RUN apt-get update -y
RUN apt-get install mariadb-server -y
RUN apt-get install mariadb-client -y

# RUN mv /etc/mysql/mariadb.cnf /etc/mysql/mariadb.cnf.bak
# COPY ./conf/mariadb.cnf /etc/mysql/mariadb.cnf

VOLUME /var/lib/mysql

EXPOSE 3306

# CMD ["service", "mariadb", "start"]
