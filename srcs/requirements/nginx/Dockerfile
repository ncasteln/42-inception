FROM debian:bullseye

RUN apt-get update -y && apt-get install -y nginx

# replace default cnofig file
COPY conf/custom.conf /etc/nginx/nginx.conf

# remove whe wordpress will be added
COPY index.html /var/www/html/
COPY index_colored.html /var/www/html/

# openssl
COPY tools/generate_ssl_cert.sh /etc/tools/
RUN /etc/tools/generate_ssl_cert.sh

# check the config file
RUN nginx -t

EXPOSE 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
