FROM debian:bullseye

# ENV USER=ncasteln


RUN apt-get update -y && apt-get install -y nginx
# COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN nginx -t

# check exit code of the configuration file
# nginx -t

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
