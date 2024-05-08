FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nginx -y

# nginx configuration
# either use conf.d & remove sites-[enabled|available]/default
# or use sites-[enabled|available]/
COPY conf/ncasteln.42.fr.conf /etc/nginx/conf.d
RUN rm -rf /etc/nginx/sites-enabled/default
RUN rm -rf /etc/nginx/sites-available/default

# openssl
COPY tools/generate_ssl_cert.sh /etc/tools/
RUN /etc/tools/generate_ssl_cert.sh

# check nginx configuration
# enble to test isolated Dockerfile
# disable in compose
# RUN nginx -t

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
