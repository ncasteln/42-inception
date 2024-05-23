# TO DO AND TO LEARN LIST
0) GENERAL
	- Why not trying Alpine? It seems lightweighter instead of Debian.

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
	- configuration general questions: (check https://dev.mysql.com/doc/refman/8.0/en/option-files.html and https://mariadb.com/kb/en/configuring-mariadb-with-option-files/#option-groups)
	- best practice to configure? use my.cnf? use 50-server.cnf? use conf.d to add rules ? maybe the last are applied so is  it easier?
		- ANSWER: in my.cnf: # If the same option is defined multiple times, the last one will apply.
		- Last incldue is !includedir /etc/mysql/mariadb.conf.d/, where the custom configuration will go
		- I can define all customs there
		- COPY of 50-server and my.cnf not needed anymore
		https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-with-nginx-on-an-ubuntu-20-04-server
	- port=3306 has to be unders [client-server] or just under [mysqld]
	- socket has to be enabled in [client-server]? What the fuck is useful for?
		- socket and port can be moved under mysqld, but in that case it won't be possible to access data from host machine, bu only thorugh the wordpress interface, which is proabably the desired thing

4) wordpress
	**TO LEARN**
	- PHP www.conf file: understand parameters

	**TO DO**
	- make it not re-installable if already installed; verify what happens by re-running the script: really necessary?
	- --allow-root remove and use sudo with www-data instead? Sudo not a good approach need gosu, but is it really important?

5) bonus
	- redis
	- phpMyAdmin
	- own website
