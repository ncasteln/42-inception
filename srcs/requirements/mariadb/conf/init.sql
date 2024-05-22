CREATE DATABASE mydatabase;
CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'myrootpassword';
FLUSH PRIVILEGES;

-- CREATE DATABASE mydatabase;
-- CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypssword';
-- GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' WITH GRANT OPTION;
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'myrootpassword';
-- FLUSH PRIVILEGES;
