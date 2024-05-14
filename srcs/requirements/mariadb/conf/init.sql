-- check https://mariadb.com/kb/en/account-management-sql-commands/

CREATE DATABASE wp_database;
CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';
FLUSH PRIVILEGES;

-- docker exec mariadb-cont mariadb -e 'use myanimalsdb; SHOW TABLES; SHOW COLUMNS IN animals;'
-- docker exec mariadb-cont mariadb -e 'SELECT user FROM mysql.user;'
