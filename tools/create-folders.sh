#!/bin/bash

G="\033[0;32m";
R="\033[0;31m"
W="\033[0m";

ENV="./srcs/.env";
WP_DATA=$(cat $ENV | grep 'WP_DATA' | awk -F '=' '{ print $2 }');
DB_DATA=$(cat $ENV | grep 'DB_DATA' | awk -F '=' '{ print $2 }');

if [[ -d $WP_DATA || -d $DB_DATA ]]; then
	echo -en "${Y}* Data folders already present in those locations:\n\
${G}+${W} $WP_DATA\n\
${G}+${W} $DB_DATA\n\
Do you want to reset them? " && read -p "[y/n] " ANSWER;
	if [ "$ANSWER" != "y" ]; then
		exit 0;
	fi
fi;

rm -rfd $WP_DATA $DB_DATA;

if [[ -e $ENV ]]; then
	echo -e "${G}* Creating folder for the volumes under:${W}
${G}+${W} $WP_DATA
${G}+${W} $DB_DATA";
	mkdir -p $WP_DATA;
	mkdir -p $DB_DATA;
	exit 0;
else
	echo -e "${R}* Error: no .env file, impossible to create required folders${W}";
	exit 1;
fi
