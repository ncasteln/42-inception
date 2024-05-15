FROM debian:bullseye

# RUN apt-get update -y
RUN apt-get update && apt-get install -y \
    nginx \
    openssl

    # RUN apt update && apt install -y \
#     nginx \
#     openssl

#&& apt-get upgrade -y
# RUN apt-get install procps -y

# nginx configuration
# either use conf.d & remove sites-[enabled|available]/default
# or use sites-[enabled|available]/
COPY conf/ncasteln.42.fr.conf /etc/nginx/conf.d
RUN rm -rf /etc/nginx/sites-enabled/default
RUN rm -rf /etc/nginx/sites-available/default

# openssl
COPY tools/generate_ssl_cert.sh /etc/tools/
RUN /etc/tools/generate_ssl_cert.sh

ENTRYPOINT [ "/usr/sbin/nginx" ]
CMD [ "-g", "daemon off;" ]
# nginx -t can be used to test config file
