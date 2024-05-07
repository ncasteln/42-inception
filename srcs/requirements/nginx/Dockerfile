FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nginx -y

# replace default cnofig file
COPY conf/default.conf /etc/nginx/conf.d

# openssl
COPY tools/generate_ssl_cert.sh /etc/tools/
RUN /etc/tools/generate_ssl_cert.sh

# check the config file
RUN nginx -t

# EXPOSE 443

ENV IS_MY_NGINX=YES

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
