# TO DO LIST
1) NGINX
	- Check fastcgi parameters and their meaning
	- Modify TLS1.2 1.3 http or is it enoguh in server ?
	- ssl_cipher brief meaning

2) Docker compose
	- init: true need to be used? Why the services don't wait some second when stopped?
	- restart: always

3) mariadb
	- rule user=mysql in 50-server.cnf what does?
	- What happens to root? -- can access without password --  
	- Is it enough the init.sql file?
	- socket
	- configuration general questions: (check https://dev.mysql.com/doc/refman/8.0/en/option-files.html)
		- best practice to configure? use my.cnf? use 50-server.cnf?
		- use conf.d to add rules ? maybe the last are applied so is it easier?
		- socket has to be enabled in [client-server]?