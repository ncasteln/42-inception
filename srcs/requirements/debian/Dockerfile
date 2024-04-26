FROM debian:bullseye






# RUN apt-get update -y

# # installation
# RUN apt-get install mariadb-server -y

# # env creation
# ENV MYSQL_ROOT_PASSWORD=root_pwd
# ENV MYSQL_DATABASE=db
# ENV MYSQL_USER=user
# ENV MYSQL_PASSWORD=pwd

# # change configuration and make backup
# RUN cp /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
# COPY ./conf/50-server.cnf /etc/mysql/my.cnf
# COPY ./conf/init.sql /etc/mysql/init.sql
# # COPY ./conf/my.cnf /etc/mysql/my.cnf

# RUN mkdir /run/mysqld

# # COPY ./tools/configure_mariadb.sh /configure_mariadb.sh
# # RUN chmod u+x /configure_mariadb.sh
# # RUN /configure_mariadb.sh

# # set the volume to the same directory set in the configuration file
# VOLUME /var/lib/mysql

# # expose port
# EXPOSE 3306

# # CMD ["mysqld_safe"]
# # CMD ["mysqld"]
