FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nginx -y

# replace default cnofig file
# decided to use conf.d --- requires to remove sites-enabled/default && sites-available/default
COPY conf/ncasteln.42.fr.conf /etc/nginx/conf.d
RUN rm -rf /etc/nginx/sites-enabled/default
RUN rm -rf /etc/nginx/sites-available/default

# remove, jut example file
# COPY index.html /var/www/html/

# remove jut test.php
# COPY test.php /var/www/html/

# openssl
# COPY tools/generate_ssl_cert.sh /etc/tools/
# RUN /etc/tools/generate_ssl_cert.sh

# check the config file
# RUN nginx -t

# EXPOSE 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
