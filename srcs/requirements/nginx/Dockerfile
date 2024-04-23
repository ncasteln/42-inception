FROM debian:bullseye

# ENV USER=ncasteln

RUN apt-get update -y && apt-get install -y nginx
COPY ./conf/custom.conf /etc/nginx/nginx.conf
RUN nginx -t

# copy static pages
COPY ./my-site /var/www/html/my-site

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
