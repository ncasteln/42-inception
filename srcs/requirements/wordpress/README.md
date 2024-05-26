# wordpress

To install wordpress there are different methods. One method could be following the official documentation and `COPY` a custom _wp-config.php_ file to the appropriate folder. Another one is using the _wp cli_.

[Offical documentation of Wordpress](https://developer.wordpress.org/advanced-administration/before-install/)  
[wp cli commands](https://developer.wordpress.org/cli/commands/)  
[how to install wp cli on debian](https://www.linode.com/docs/guides/how-to-install-wordpress-using-wp-cli-on-debian-10/)  

# php-fpm
_PHP-FPM_ means FastCGI Process Manager, which handles requests using [FastCGI protocol](../nginx/README.md/#cgi--fastcgi). It is an alternative to _PHP FastCGI_ implementation. It can improve performances and optimize resources thanks to its fine-tune configuration, whose customization can take in account the server needs and capacity.  
Just to make a simple example, we can set the max number of child processes, the max number of request that each child can handle before being recycled (to get rid of **memory leaks!**), its timout when idle, the max amount of memory each child can reserve etc. Note that the php children processes are something different and unrelated to the nginx workers.

[PHP-FPM introduction](https://dev.to/arsalanmee/understanding-php-fpm-a-comprehensive-guide-3ng8)  
[How PHP-FPM works](https://medium.com/@mgonzalezbaile/demystifying-nginx-and-php-fpm-for-php-developers-bba548dd38f9)  
[Installation specific for Debian distro](https://wiki.debian.org/PHP)  
[Official php manual](https://www.php.net/manual/en/install.fpm.configuration.php) for configuration  
[Configuration tutorial](https://www.digitalocean.com/community/tutorials/php-fpm-nginx)  

# configuration file
- `find . -name php` usually it'll be in /etc/php/7.4/fpm
- 

## env_file
While using `ENV` keyword in Dockerfile, makes the env variables available for the building stage, `env_file` of docker compose acts differently, and the variable are not available when creating the image. Because of this, the installation of wordpress using the `wp` CLI has to be peformed runtime, when the environment exists.

## Others
https://www.ionos.com/digitalguide/server/know-how/wordpress-in-docker-containers/
