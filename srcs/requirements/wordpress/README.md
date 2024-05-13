# wordpress
(Offical documentation of Wordpress)[https://developer.wordpress.org/advanced-administration/before-install/]  

# php-fpm
(php)[https://wiki.debian.org/PHP] installation specific for Debian distro  
Official (php manual)[https://www.php.net/manual/en/install.fpm.configuration.php] for configuration  
Configure (php-fpm)[https://www.digitalocean.com/community/tutorials/php-fpm-nginx]  

# configuration file
- `find . -name php` usually it'll be in /etc/php/7.4/fpm
- 

## env_file
While using `ENV` keyword in Dockerfile, makes the env variables available for the building stage, `env_file` of docker compose acts differently, and the variable are not available when creating the image. Because of this, the installation of wordpress using the `wp` CLI has to be peformed runtime, when the environment exists.

## Others
https://www.ionos.com/digitalguide/server/know-how/wordpress-in-docker-containers/
