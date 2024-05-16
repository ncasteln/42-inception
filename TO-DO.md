# TO DO AND TO LEARN LIST
1) NGINX
	**TO LEARN**
	- Check fastcgi parameters and their meaning
	- Modify TLS1.2 1.3 http or is it enoguh in server ?
	- keepalive timeout ?
	- ssl_cipher brief meaning

2) Docker compose
	**TO LEARN**
	- init: true need to be used? Why the services don't wait some second when stopped?
	- need to install always the same fixed version?
	- add secrets: is it really a smart thing to do ? Wait for answer

3) mariadb
	**TO DO**
	- use --bootstrap for mariadbd ? It seemed a good idea
	- Check if exists the anonymouse user
	- What happens to root?
		- Try to access without password
	- rule user=mysql in 50-server.cnf what does?
		- verify using ps aux like wordpress: it should set the running user as mysql
	
	**TO LEARN**
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
	**TO LEARN**
	- Verify the user which runs the php service
	- PHP www.conf file: understand parameters

	**TO DO**
	- make it not re-installable if already installed; verify what happens by re-running the script
	- --allow-root remove and use sudo with www-data instead? Sudo not a good approach need gosu, but is it really important?

5) bonus
	- redis
	- phpMyAdmin
	- own website
