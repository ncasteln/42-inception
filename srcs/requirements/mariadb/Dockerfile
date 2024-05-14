FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/custom.cnf /etc/mysql/mariadb.conf.d/

# copy file to initialize a custom database (init_file)
# necessary to start the service alternative to mariadb_install_tables or something similar
COPY conf/init.sql /etc/mysql/init.sql
RUN chown root:root /etc/mysql/init.sql

# purge mysql
# RUN rm -rfd /var/lib/mysql
# RUN mariadb-install-db

# COPY tools/docker-entrypoint.sh /docker-entrypoint.sh
# RUN /docker-entrypoint.sh

# ENTRYPOINT [ "tail", "-f" ]
# ENTRYPOINT [ "/docker-entrypoint.sh" ]
ENTRYPOINT [ "mariadbd" ]

# PROBLEM
# How can i have an .sql file which contains variables?
# If i try another approach by using scripts, how can i add database before starting, like the init_file does?
# Is it ok to have /run/secrets/something which is pretty readable from outside? How can avoid it ?


# https://stackoverflow.com/questions/48044904/docker-mariadb-doesnt-start-at-init-based-in-debianstable



# Installing MariaDB/MySQL system tables in '/var/lib/mysql' ...
# OK

# To start mariadbd at boot time you have to copy
# support-files/mariadb.service to the right place for your system


# Two all-privilege accounts were created.
# One is root@localhost, it has no password, but you need to
# be system 'root' user to connect. Use, for example, sudo mysql
# The second is mysql@localhost, it has no password either, but
# you need to be the system 'mysql' user to connect.
# After connecting you can set the password, if you would need to be
# able to connect as any of these users with a password and without sudo

# See the MariaDB Knowledgebase at https://mariadb.com/kb

# You can start the MariaDB daemon with:
# cd '/usr' ; /usr/bin/mariadb-safe --datadir='/var/lib/mysql'

# You can test the MariaDB daemon with mysql-test-run.pl
# cd '/usr/share/mysql/mysql-test' ; perl mariadb-test-run.pl

# Please report any problems at https://mariadb.org/jira

# The latest information about MariaDB is available at https://mariadb.org/.

# Consider joining MariaDB's strong and vibrant community:
# https://mariadb.org/get-involved/
