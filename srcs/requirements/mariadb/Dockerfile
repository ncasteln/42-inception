FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server -y

# replacing my.cnf file
RUN mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
COPY conf/my.cnf /etc/mysql/my.cnf

# replacing 50-server.cnf file
RUN mv /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf.bak
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# copy file to initialize a custom database (init_file)
COPY conf/init.sql /etc/mysql/init.sql

EXPOSE 3306

ENTRYPOINT [ "mariadbd" ]





# ENV MYSQL_ROOT_PASSWORD=root_pwd
# ENV MYSQL_DATABASE=db
# ENV MYSQL_USER=user
# ENV MYSQL_PASSWORD=pwd


# RUN apt-get update -y
# RUN apt-get install systemctl -y
# RUN apt-get install mariadb-server -y

# EXPOSE 3306

# # CMD ["mysqld"]
# CMD ["mysqld_safe"]
# ENTRYPOINT ["systemctl", "enable", "mariadb.service"]


# FROM debian:latest

# # groupadd -r, --system group/account
# # useradd -r -g(primary group)
# RUN groupadd mysql
# RUN useradd -g mysql mysql --home-dir /var/lib/mysql

# RUN apt-get update -y && apt-get install -y mariadb-server

# # debconf-show mariadb-server to log the result
# RUN echo "mariadb-server" mysql-server/root_password password 'unused' | debconf-set-selections
# RUN echo "mariadb-server" mysql-server/root_password_again password 'unused' | debconf-set-selections

# # purge an recreate /var/lib/mysql with appropriate ownership
# RUN rm -rf /var/lib/mysql /etc/mysql/mariadb.conf.d/50-mysqld_safe.cnf;\
# 	mkdir -p /var/lib/mysql /run/mysqld;\
# 	chown -R mysql:mysql /var/lib/mysql /run/mysqld;\
# 	chmod 1777 /run/mysqld;

# # change order of include in my.cnf - remove and use a my.cnf instead
# # RUN sed -i -e '/includedir/ {N;s/\(.*\)\n\(.*\)/\n\2\n\1/}' /etc/mysql/mariadb.cnf;
# RUN mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
# COPY conf/my.cnf /etc/mysql/my.cnf

# VOLUME /var/lib/mysql

# COPY conf/docker-entrypoint.sh /usr/local/bin/
# COPY conf/init.sql /
# # ENTRYPOINT ["docker-entrypoint.sh"]

# EXPOSE 3306
# # CMD ["mariadbd"]



# # # installation
# # RUN apt-get install mariadb-server -y

# # # env creation
# # ENV MYSQL_ROOT_PASSWORD=root_pwd
# # ENV MYSQL_DATABASE=db
# # ENV MYSQL_USER=user
# # ENV MYSQL_PASSWORD=pwd

# # # change configuration and make backup
# # RUN cp /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
# # COPY ./conf/50-server.cnf /etc/mysql/my.cnf
# # COPY ./conf/init.sql /etc/mysql/init.sql
# # # COPY ./conf/my.cnf /etc/mysql/my.cnf

# # RUN mkdir /run/mysqld

# # # COPY ./tools/configure_mariadb.sh /configure_mariadb.sh
# # # RUN chmod u+x /configure_mariadb.sh
# # # RUN /configure_mariadb.sh

# # # set the volume to the same directory set in the configuration file
# # VOLUME /var/lib/mysql

# # # expose port
# # EXPOSE 3306

# # # CMD ["mysqld_safe"]
# # # CMD ["mysqld"]
