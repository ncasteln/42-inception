-- check https://mariadb.com/kb/en/account-management-sql-commands/

CREATE DATABASE wp_database;
CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE DATABASE myanimalsdb;
USE myanimalsdb;
CREATE TABLE animals (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	species VARCHAR(255) NOT NULL,
	age INT NOT NULL
);
ALTER TABLE animals
ADD weight DECIMAL(5,2),
ADD diet VARCHAR(255),
ADD habitat VARCHAR(255);
-- docker exec mariadb-cont mariadb -e 'use myanimalsdb; SHOW TABLES; SHOW COLUMNS IN animals;'


-- docker exec mariadb-cont mariadb -e 'SELECT user FROM mysql.user;'