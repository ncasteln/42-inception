# mariadb

mariaDB is a fork of MySql, open-source relational database management system. While _relational_ db are structured in rown and columns, the _non-relational_ organize the data in docs, collections, graphs, in a more flexible and complex structure. Check (pros and cons)[https://www.hostinger.com/tutorials/mariadb-vs-mysql] of mariaDB and MySql.

## Basics

## Configuration files
Configuration files can be found in:  
- /etc/mysql/my.cnf
- /etc/mysql/conf.d/
- /etc/mysql/mariadb.conf.d/
	- 50-client.cnf, config options for clients
	- 50-mysql-clients.cnf, config options CLI
	- 50-mysqld_safe.cnf
	- 50-server.cnf, config options for server
	- 60-galera.cnf

To understand which file is being used by default after the installation with `apt-get install mariadb-server`, we can check some configurations (`mysqld` = daemon, means server service; `mysql` = client) inside `/etc/mysql/mariadb.cnf`. In general, remember that `mysqld` is a symlink to `mariadb`! By an accurate reading we can then:
```bash
# Print out the files which are read for the configuration; they are read in that order, and they don't replace themselves, instead they _ADD_ the rules.
mysqld --verbose --help | grep -A 1 'Default option'

# Check the rules that are set by the read of the above mentioned file
mysqld --print-defaults
```


## Useful links
(mysql_secure_installation) raw file [https://github.com/twitter-forks/mysql/blob/master/scripts/mysql_secure_installation.sh]  
mariadb (configurations)[https://mariadb.com/kb/en/configuring-mariadb-with-option-files/] options

https://stackoverflow.com/questions/24270733/automate-mysql-secure-installation-with-echo-command-via-a-shell-script
https://stackoverflow.com/questions/64883580/wsl-cant-connect-to-local-mysql-server-through-socket-var-run-mysqld-mysqld
https://docs.bitnami.com/virtual-machine/infrastructure/nginx/administration/connect-remotely-mariadb/