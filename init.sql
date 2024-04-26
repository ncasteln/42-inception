CREATE DATABASE mydatabase;
use mydatabase;
CREATE TABLE mytable (
	animals VARCHAR(50),
	colors VARCHAR(50),
	fruits VARCHAR(50),
	numbers VARCHAR(50)
);
INSERT INTO mytable (animals, colors, fruits, numbers) VALUES
('dog', 'blue', 'melon', '999'),
('cat', 'yellow', 'banana', '677'),
('lion', 'red', 'apple', '12');

-- SHOWS
SHOW DATABASES;
SHOW TABLES;
SHOW mytable;
SHOW COLUMNS IN mytable;
SELECT animals,colors FROM mytable;


-- ADDED VOLUME TO DOCKERIFILE
-- 1) CREATE DB
	-- docker volume create db
-- 1) CREATE IMAGE
	-- docker build -t mariadb-img .
-- 2) RUN CONTAINER
	-- docker run --volume db:/var/lib/mysql  --name mariadb-serv-1 --detach  mariadb-img
	-- docker run --volume db:/var/lib/mysql  --name mariadb-serv-2 --detach  mariadb-img
-- 3) POPULATE DATABASE WITH CUSTOM ENTRIES
	-- docker exec -it mariadb-serv-1 mariadb -uroot -p
-- At some point the second container stops if try to access
