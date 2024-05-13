# TO DO LIST
1) NGINX
	- Check fastcgi parameters and their meaning
	- Modify TLS1.2 1.3 http or is it enoguh in server ?
	- ssl_cipher brief meaning

2) Docker compose
	- init: true need to be used? Why the services don't wait some second when stopped?
	- restart: always
	- need to install always same version?

3) mariadb
	- use phpMyAdmin to check the database
	- rule user=mysql in 50-server.cnf what does?
	- What happens to root? -- can access without password --  
	- Is it enough the init.sql file?
	- socket
	- configuration general questions: (check https://dev.mysql.com/doc/refman/8.0/en/option-files.html and https://mariadb.com/kb/en/configuring-mariadb-with-option-files/#option-groups)
		- best practice to configure? use my.cnf? use 50-server.cnf? use conf.d to add rules ? maybe the last are applied so is  it easier?
			- ANSWER: in my.cnf: # If the same option is defined multiple times, the last one will apply.
			- Last incldue is !includedir /etc/mysql/mariadb.conf.d/, where the custom configuration will go
			- I can define all customs there
			- COPY of 50-server and my.cnf not needed anymore
			https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-with-nginx-on-an-ubuntu-20-04-server
		- port=3306 has to be unders [client-server] or jut under [mysqld]
		- socket has to be enabled in [client-server]? What the fuck is useful for?
			- socket and port can be moved under mysqld, but in that case it won't be possible to access data from host machine, bu only thorugh the wordpress interface, which is proabably the desired thing

4) wordpress
	- If done manually everything works about the installation BUT NOTHING is shown when try to access from the browser, why?
	- Possible wrong config in nginx? Maybe jut use var/www/html ?
