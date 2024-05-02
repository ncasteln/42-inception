-- check https://mariadb.com/kb/en/account-management-sql-commands/
CREATE DATABASE mydatabase;
CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;