# MARIADB
mariaDB is a fork of MySql, open-source relational database management system. While _relational_ db are structured in rown and columns, the _non-relational_ organize the data in docs, collections, graphs, in a more flexible and complex structure. Check [pros and cons](https://www.hostinger.com/tutorials/mariadb-vs-mysql) of mariadb and MySql.

## Pre-training
Before creating your own Dockerfile, try to run a mariadb-server container using the ready-to-use docker-hub images. Try to access the database by connecting to the running server. In this example I accomplish it using the docker CLI, but it can be done also with `Dockerfile` or `docker compose`. 
```bash
$ docker network create mariadb-network;

$ docker run --name=mariadb-server --detach --network mariadb-network --env='MYSQL_ROOT_PASSWORD=myrootpassword' mariadb:latest;

# (optional) Try to populate the container: `docker exec -it mariadb-server mariadb -u root -p;

$ docker run -it --rm --name=mariadb-client --network mariadb-network mariadb:latest mariadb -u root -h mariadb-server -p;
```

## Write your own Dockerfile
### mariadb configuration
When we create a plain container in which we have to start mariadb-server, we need first to install it and then understand how the configuration works. An easy way to get the information about the settings used when starting the server, which can be done also in the pre-training step, is by using the following commands:
```bash
# Print out the files which are read for the configuration; they are read in that order, and they don't replace themselves, instead they _ADD_ the rules.
$ mariadbd --verbose --help;
$ mariadbd --verbose --help | grep -A 1 'Default option';

# Check the rules that are set by the read of the above mentioned file
$ mariadbd --print-defaults;
```
To understand how the configuration is processed, we have to look at the _/etc/mysql/my.cnf_ file, in which we can read the order with which the files and the rules are executed. We have then to make a decision about where to put the file with our custom configuration. We can either modify the _my.cnf_ file, or add a new one in a specified folder. Important to note, is that in case of multiple same rules, only the last one is executed (another approach involves passing the rules by command line, but I didn't explore enough this topic).

About the configuration, here you can find the official docs about [configuration of mysql](https://dev.mysql.com/doc/refman/8.0/en/option-files.html) and [mariadb](https://mariadb.com/kb/en/configuring-mariadb-with-option-files/#option-groups) using option files. Check also this about the [configuration rules](https://mariadb.com/kb/en/server-system-variables/#socket) explained.

In my approach I created a _custom.conf_ filw holding all the rules, and copying it into the last included folder. Notes about rules:

#### init.sql
Mariadb and mysql need data to be started. This data has to be in someway initialized. Normally you would run `mariadb-secure-installation` or `mariadb-install-db`, but since we have to automate everything in this project, we have to find another way to do it. After talking with some people, I have noticed that they used `mariadb --bootstrap` to initialize the data, but since I didn't find a real documentation about it, I preferred to add the rule _init_file_ under the [server] group, and create an _init.sql_ which initializes the data. The result it is pretty the same with one difference: by using `--bootstrap` it is possible to remove the file before starting the container, but this doesn't really make a difference, because the data could still be removed right after container creation, and it isn't really more secure than the second approach.
#### socket
If you have some errors related to this rule, first understand what is a socket, second, understand what is the error. You probably need to create a specific folder for it, or change the folder in the rule. Check here, someone that had already the [socket](https://stackoverflow.com/questions/64883580/wsl-cant-connect-to-local-mysql-server-through-socket-var-run-mysqld-mysqld) configuration problem.
#### bind-address
You can set to multiple options, and the database will still work. You can set it to `0.0.0.0`, you can set it to `mariadb`, you can add the name of the network like `mariadb.[network]`. Just make something meaningful. You can even use `skip-bind-address` or commenting out `bind-address`.

### How to test the server
*mysqld* had a `--validate-config` flag which seems to don't work as intended for mariadb. To test if the db is working, we can run the mariadb-server and then access it using a mariadb-client, either inside the same container, or even better, from another one which share a same _docker network_. If somehting doesn't work, make it working!
```bash
$ docker network create mariadb-network;

$ docker run --name [container-name] -d --network mariadb-network [mariadb-server-img];

$ docker container inspect mariadb-server; # to retrieve server ip address

$ docker run --name [container-name] -d --network mariadb-network [mariadb-client-img];

$ docker exec mariadb -u[created-user] -h[host-address] -p;
```

### Healthcheck
Since the nginx needs Wordpress, and Wordpress needs mariadb, a good practice (but not always necessary) is to use [healthchecks](https://docs.docker.com/reference/dockerfile/#healthcheck) to make a container waiting another, based on its condition, if healthy or not. You can imagine this like an if confition which checks true and false, and states that everything is ok only when the condition is true.

I added an healthcheck for mariadb container, so that wordpress waits tha mariadb is healthy. `mysqladmin ping` is used to perform this check. To understand how it properly works, check the [official mysql documentation](https://dev.mysql.com/doc/refman/8.0/en/mysqladmin.html). Important to note, that `mysqladmin ping` returns 0 also in case of _Access denied_ because that has a different meaning from a not-running server.

## Quick reference
- `mariadb -h[hostname] -u[username] -p[passowrd]` login into database. Be aware that you had to grant the privileges to that user. If `-h` is not specified, the default value is localhost. If `-p` is not typed, you'll be asked to insert it.
- `mariadb -e '[mariadb-instruction]'` the instructions can be chained into long scripts like the following.
- `mariadb -e 'use mydatabase; SHOW TABLES; SHOW COLUMNS IN [db-name]; SELECT display_name FROM [db-name_users];'` check the users in the database.

## Useful links
- Good general tutorial for [mysql](https://www.mysqltutorial.org/mysql-administration/) and [mariadb](https://www.mariadbtutorial.com/).
- [mysql_secure_installation](https://github.com/twitter-forks/mysql/blob/master/scripts/mysql_secure_installation.sh) to get what's happening when running that command.
- mariadb [cheatsheet](https://www.devguide.at/wp-content/uploads/2021/01/osdc_cheatsheet-mariadb.pdf).
- [Interesting answer](https://stackoverflow.com/questions/77867808/mariadb-in-docker-works-with-managed-volume-but-not-with-mapped) about what we have to do.
