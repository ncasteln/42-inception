FROM debian:bullseye

ENV MYSQL_ROOT_PASSWORD=root_pwd
ENV MYSQL_DATABASE=db
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=pwd


RUN apt-get update -y
RUN apt-get install systemctl -y
RUN apt-get install mariadb-server -y

EXPOSE 3306

# CMD ["mysqld"]
CMD ["mysqld_safe"]
# ENTRYPOINT ["systemctl", "enable", "mariadb.service"]