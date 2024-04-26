FROM mariadb:latest

ENV MARIADB_ROOT_PASSWORD=mypassword

COPY init.sql /

VOLUME ./test-data/

EXPOSE 3306
