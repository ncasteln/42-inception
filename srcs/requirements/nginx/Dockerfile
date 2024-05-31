FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
    nginx \
    openssl

# place configuration file
COPY conf/ncasteln.42.fr.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/ncasteln.42.fr.conf /etc/nginx/sites-enabled/
RUN rm -rf /etc/nginx/sites-enabled/default

# openssl
COPY tools/generate-ssl-cert.sh /etc/tools/
RUN /etc/tools/generate-ssl-cert.sh

ENTRYPOINT [ "/usr/sbin/nginx" ]
CMD [ "-g", "daemon off;" ]
# nginx -t can be used to test config file
