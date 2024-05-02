# mariadb

mariaDB is a fork of MySql, open-source relational database management system. While _relational_ db are structured in rown and columns, the _non-relational_ organize the data in docs, collections, graphs, in a more flexible and complex structure. Check (pros and cons)[https://www.hostinger.com/tutorials/mariadb-vs-mysql] of mariaDB and MySql.

```bash
# Print out the files which are read for the configuration; they are read in that order, and they don't replace themselves, instead they _ADD_ the rules.
mariadbd --verbose --help | grep -A 1 'Default option'

# Check the rules that are set by the read of the above mentioned file
mariadbd --print-defaults
```  

From the output, I know that conf file are read in this order:
- /etc/my.cnf
- /etc/mysql/my.cnf
- ~/.my.cnf
And _/etc/mysql/my.cnf_ will include the followings:
- !includedir /etc/mysql/conf.d/ which includes two small conf (mysql.cnf and mysqldump.cnf)
- !includedir /etc/mysql/mariadb.conf.d/ which includes more files (50-server.cnf etc.)

https://www.mysqltutorial.org/mysql-administration/

## Useful links
(mysql_secure_installation) raw file [https://github.com/twitter-forks/mysql/blob/master/scripts/mysql_secure_installation.sh]  
mariadb (configurations)[https://mariadb.com/kb/en/configuring-mariadb-with-option-files/] options

https://stackoverflow.com/questions/24270733/automate-mysql-secure-installation-with-echo-command-via-a-shell-script
https://stackoverflow.com/questions/64883580/wsl-cant-connect-to-local-mysql-server-through-socket-var-run-mysqld-mysqld
https://docs.bitnami.com/virtual-machine/infrastructure/nginx/administration/connect-remotely-mariadb/

https://gist.github.com/Mins/4602864
https://www.devguide.at/wp-content/uploads/2021/01/osdc_cheatsheet-mariadb.pdf