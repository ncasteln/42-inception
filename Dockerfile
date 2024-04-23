FROM debian:bullseye

ENV USER=ncasteln

RUN apt-get update -y && apt-get install -y nginx
RUN nginx -t
# -t check config file

RUN useradd --create-home --shell /bin/bash ncasteln

USER ncasteln
WORKDIR /home/ncasteln
