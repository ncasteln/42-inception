# TO DO AND TO LEARN LIST
0) GENERAL
	**TO DO**
	- Change hostname in the various places!
	- How protect secrets: /run/secrets/...; remove init.sql (maybe possible in makefile)
	- One or Two networks????
	- healtchecks params
	- network: how to set up? Possibilities: 
		1) set up an inception connection, shared between all the services -- BAD PRACTICE? https://www.docker.com/blog/docker-networking-design-philosophy/
		2) set up two different connection -- BETTER, but how can i bind-address to only one address?
			TRY: 
				-- make a new branch to revert

				-- add the IPV4 to wordpress 
				-- change bind-address in custom.conf 
				-- change script that generates init.sql file

				-- additionaly create the others IPV4 and change:
					-- wordpress www.conf
					-- nginx ncasteln.conf

1) NGINX
	**TO LEARN**
	- Check fastcgi parameters and their meaning
	- keepalive timeout ?
	- ssl_cipher brief meaning

2) Docker compose
	**TO LEARN**
	- init: true need to be used? Why the services don't wait some second when stopped?
		ANSWER: try mariadb because somewhere was suggested that myabe SIGTERM i not handled. Just try it.
		RESULT: init doesn't change anything when mariadb container is stopped. So what?
	- need to install always the same fixed version?
		ANSWER: sure no need but can be tried. Add check which check by RUNTIME apt-get list --upgradeable; check which is the result to make condition true or false.
	- add secrets: is it really a smart thing to do ? Wait for answer
		ANSWER: probably it's not a problem, since the docker inside the machine could be accessed only via sudo.

3) mariadb
	**TO DO**
	- Like bootstrap, maybe is possible to set the configuration by command line, which would get rid of the necessity to use the configuration files. TRY!
	- use --bootstrap for mariadbd ? It seemed a good idea
		ANSWER: https://mariadb.com/kb/en/mariadbd-options/#-bootstrap 
		UPDATE: it seems there is no way
		
	**TO LEARN**
	- port=3306 has to be unders [client-server] or just under [mysqld]
	- socket has to be enabled in [client-server]? What the fuck is useful for?
		ANSWER: socket and port can be moved under mysqld, but in that case it won't be possible to access data from host machine, bu only thorugh the wordpress interface, which is proabably the desired thing

4) wordpress
	**TO LEARN**
	- PHP www.conf file: understand parameters
		- 0.0.0.0 use wordpress_ip instead?
		- other changed need to be?

	**TO DO**
	- Thing about the 2 users: how should be organized ?
	- make it not re-installable if already installed; verify what happens by re-running the script: really necessary?
	- --allow-root remove and use sudo with www-data instead? Sudo not a good approach need gosu, but is it really important?

5) bonus
	- redis
	- phpMyAdmin
	- own website

6) TO REMOVE:
- nginx/conf/nginxconf
- mariadb/conf/50-server
- mariadb/conf/my.cnf

7) GITIGNORE
- compose/ folder
- README.md files
- .vscode
