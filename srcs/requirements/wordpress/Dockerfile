FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# worpress install
COPY tools/install_wp.sh /install_wp.sh
RUN ./install_wp.sh

# copy of the config file
# TO DO: add randomized values https://api.wordpress.org/secret-key/1.1/salt/
COPY conf/wp-config.php /var/www/wordpress/

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nginx -y

# replace default cnofig file
COPY conf/custom.conf /etc/nginx/nginx.conf
