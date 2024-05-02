FROM debian:latest

RUN apt-get update -y && apt-get install mariadb-server -y

ENV MYSQL_ROOT_PASSWORD=root_pwd
ENV MYSQL_DATABASE=db
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=pwd

# add the file with custom configurations
RUN mv /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf.bak
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# https://mariadb.com/kb/en/server-system-variables/#init_file
COPY conf/init.sql /etc/mysql/init.sql

# RUN mkdir /run/mysqld

VOLUME /var/lib/mysql

EXPOSE 3306

# CMD ["mariadbd"]