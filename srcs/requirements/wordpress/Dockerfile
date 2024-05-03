FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# worpress install
# COPY tools/install_wp.sh /install_wp.sh
# RUN ./install_wp.sh

# install wp
COPY tools/install_wp.sh /install_wp.sh
RUN ./install_wp.sh

EXPOSE 9000