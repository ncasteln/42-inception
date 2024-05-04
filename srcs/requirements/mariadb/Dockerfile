FROM debian:bullseye

ENV MYSQL_ROOT_PASSWORD=myrootpassword
ENV MYSQL_DATABASE=mydatabase
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server -y

# replacing my.cnf file
RUN mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
COPY conf/my.cnf /etc/mysql/my.cnf

# replacing 50-server.cnf file - the last rules overwrite the first
RUN mv /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf.bak
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# copy file to initialize a custom database (init_file)
# necessary to start the service
COPY conf/init.sql /etc/mysql/init.sql

EXPOSE 3306

ENTRYPOINT [ "mariadbd" ]