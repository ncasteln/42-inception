# mariadb

mariaDB is a fork of MySql, open-source relational database management system. While _relational_ db are structured in rown and columns, the _non-relational_ organize the data in docs, collections, graphs, in a more flexible and complex structure. Check (pros and cons)[https://www.hostinger.com/tutorials/mariadb-vs-mysql] of mariaDB and MySql.

## Pre-training
Run a mariadb-server container and  after a client using docker-hub images.
```bash
docker network create mariadb-network;  
docker run --name=mariadb-server --detach --network mariadb-network --env='MYSQL_ROOT_PASSWORD=myrootpassword' mariadb:latest;  
(optional) Try to populate the container: `docker exec -it mariadb-server mariadb -u root -p;  
docker run -it --rm --name=mariadb-client --network mariadb-network mariadb:latest mariadb -u root -h mariadb-server -p;  
```

## Configuration
In _/etc/mysql/my.cnf_ we read the order in which the files and the rules are processed. What is done:
- Create an _init.sql_ which initializes a custom database (necessary!).
- Copy a custom _50-server.cnf_: under [mysqld] add _port_ and _socket_ rules, change _bind_address_ to 0.0.0.0. Under [server] add _init_file_.
- Copy a custom _my.cnf_ file, in which port and socket are commented.

https://dev.mysql.com/doc/refman/8.0/en/option-files.html
https://mariadb.com/kb/en/configuring-mariadb-with-option-files/#option-groups

### How to test it
*mysqld* had a `--validate-config` flag which seems to don't work ad intended. To test if the db is working, we can run the mariadb-server and then access it using a mariadb-client container, which share a same _docker network_.
- `docker network create mariadb-network`
- Add `--network mariadb-network` to docker run of the mariadb-server
- Find the IP address of the server with `docker container inspect mariadb-server`
- Run mariadb-server
- Run mariadb-client, remembering to add the network
- Execute `mariadb -u [created-user] -h [ip-address] -p` in the client

### How to open database inside the same container
- Remove `ENTRYPOINT [ "mariadbd" ]` from Dockerfile
- Change --detach to -it mode in docker run
- Change 50-server.cnf, commenting the socket rule

```bash
# Print out the files which are read for the configuration; they are read in that order, and they don't replace themselves, instead they _ADD_ the rules.
mariadbd --verbose --help
mariadbd --verbose --help | grep -A 1 'Default option'

# Check the rules that are set by the read of the above mentioned file
mariadbd --print-defaults
```  

### Rules
- (_bind-address_)[https://mariadb.com/kb/en/configuring-mariadb-for-remote-client-access/]: the default is 127.0.0.1, therefore is necessary change it to _0.0.0.0_or use the rule _skip-bind-address_.
- 

### Healthcheck
A simple healthcheck is performed, so that wordpress waits tha mariadb is healthy. `mysqladmin ping` is used to perform this check. To understand how it works properly, check the (official mysql documentation)[https://dev.mysql.com/doc/refman/8.0/en/mysqladmin.html]. Important to note, that `mysqladmin ping` returns 0 also in case of _Access denied_ because that has a different meaning from a not-running server.

## Quick reference
# show users
- `mariadb -e '[mariadb-instruction]'` the instructions can be chained into long scripts like the following
- `mariadb -e 'use mydatabase; SHOW TABLES; SHOW COLUMNS IN wp_users; SELECT display_name FROM wp_users;'`

## Useful links
(Configuration of mysql)[https://dev.mysql.com/doc/refman/8.0/en/option-files.html] using option files.
(Configuration rules explained)[https://mariadb.com/kb/en/server-system-variables/#socket].

Good general tutorial for (mysql)[https://www.mysqltutorial.org/mysql-administration/] and (mariadb)[https://www.mariadbtutorial.com/]

(mysql_secure_installation) raw file [https://github.com/twitter-forks/mysql/blob/master/scripts/mysql_secure_installation.sh]  

https://stackoverflow.com/questions/24270733/automate-mysql-secure-installation-with-echo-command-via-a-shell-script
https://stackoverflow.com/questions/64883580/wsl-cant-connect-to-local-mysql-server-through-socket-var-run-mysqld-mysqld
https://docs.bitnami.com/virtual-machine/infrastructure/nginx/administration/connect-remotely-mariadb/

https://gist.github.com/Mins/4602864
https://www.devguide.at/wp-content/uploads/2021/01/osdc_cheatsheet-mariadb.pdf

https://stackoverflow.com/questions/77867808/mariadb-in-docker-works-with-managed-volume-but-not-with-mapped
