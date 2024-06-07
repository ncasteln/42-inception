# WORDPRESS

To install wordpress there are different methods. One method could be following the official documentation and `COPY` a custom _wp-config.php_ file to the appropriate folder. Another one is using the _wp cli_.

- [wp cli](https://developer.wordpress.org/cli/commands/) commands.
- The best guide I found on the web on [how to install wp cli on debian](https://www.linode.com/docs/guides/how-to-install-wordpress-using-wp-cli-on-debian-10/).
- [Offical documentation of Wordpress](https://developer.wordpress.org/advanced-administration/before-install/).

# PHP-FPM
_PHP-FPM_ means FastCGI Process Manager, which handles requests using [FastCGI protocol](../nginx/README.md/#cgi--fastcgi). It is an alternative to _PHP FastCGI_ implementation. It can improve performances and optimize resources thanks to its fine-tune configuration, whose customization can take in account the server needs and capacity.

For example, we can set the max number of child processes, the max number of request that each child can handle before being recycled (to get rid of **memory leaks!**), its timout when idle, the max amount of memory each child can reserve etc. Note that the php children processes are something different and unrelated to the nginx workers.

The minimal configuration of php is pretty simple. The main file is _www.conf_ which can be located in _/etc/php/7.4/fpm/pool.d/_. There we have to modify the `listen` directive, and pass the ip address of wordpress. Yes, there is a trick on this, like any other `docker network` you decide to set up. 

- [PHP-FPM introduction](https://dev.to/arsalanmee/understanding-php-fpm-a-comprehensive-guide-3ng8)  
- [How PHP-FPM works](https://medium.com/@mgonzalezbaile/demystifying-nginx-and-php-fpm-for-php-developers-bba548dd38f9)  
- [Installation specific for Debian distro](https://wiki.debian.org/PHP)  
- [Official php manual](https://www.php.net/manual/en/install.fpm.configuration.php) for configuration  
- [Configuration tutorial](https://www.digitalocean.com/community/tutorials/php-fpm-nginx)  
