FROM debian:bullseye

# ENV USER=ncasteln

RUN apt-get update -y && apt-get install -y nginx
COPY ./conf/custom.conf /etc/nginx/nginx.conf
RUN nginx -t

# content
COPY ./my-site/index.html /var/www/html/
COPY ./my-site/animals/index.html /var/www/html/animals/
COPY ./my-site/animals/styles.css /var/www/html/animals/
COPY ./my-site/fruits/fruits.html /var/www/html/fruits/

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
