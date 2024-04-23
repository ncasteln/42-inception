FROM debian:bullseye

ENV USER=ncasteln

RUN apt-get update -y
RUN useradd --create-home --shell /bin/bash ncasteln

# install wget and wordpress
RUN apt-get install wget -y
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz

# USER ncasteln

# COPY ./srcs/requirements/nginx/my-site ./home/my-site