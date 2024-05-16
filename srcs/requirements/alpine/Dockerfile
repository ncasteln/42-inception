FROM alpine:latest

RUN apk update -y && apk add -y \
	nginx \
	openssl

COPY conf/ncasteln.42.fr.conf /etc/nginx/conf.d
# remove the famous folder ?
# Check if they exist or not

COPY tools/generate-ssl-cert.sh /etc/tools/
RUN /etc/tools/generate-ssl-cert.sh

ENTRYPOINT [ "/usr/sbin/nginx" ]
CMD [ "-g", "daemon off;" ]
