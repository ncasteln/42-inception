#!/bin/bash

G="\033[0;32m";
R="\033[0;31m"
W="\033[0m";

if [[ -d "$@/data/wp_data" || -d "$@/data/db_data" ]]; then
	echo -en "${G}* Volume folders already present, do you want to reset them?${W} " && read -p "[y/n] " ANSWER
	if [ "$ANSWER" = 'y' ]; then
		sudo docker volume rm mariadb_vol;
		sudo docker volume rm wp_nginx_vol;
		rm -rfd "$@/data/wp_data" "$@/data/db_data"
	else
		exit 0;
	fi
else
	echo -e "${G}* Creating volume folder in "$@/data/"...${W}"
	mkdir -p "$@/data/wp_data" "$@/data/db_data"
fi;
