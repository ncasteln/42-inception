#!/bin/bash

G="\033[0;32m";
Y="\033[0;33m";
R="\033[0;31m";
W="\033[0m";

USER="ncasteln"
DOMAIN="$USER.42.fr"
DATA="/home/$USER"
ENV="./srcs/.env"

if [ "$EUID" -ne 0 ]; then
  echo -e "${Y}* Inception requires root permissions, please re run with sudo.";
  exit 1;
fi

echo -e "${G}************** [ INCEPTION by ncasteln ] **************";
echo -e "This script will help you to run inception on your system\n${W}";

# domain
echo -e "${G}*${W} The domain used in the project will be ${G}$DOMAIN${W}";
echo -e "${G}*${W} The data folder is created under ${G}$DATA${W}";


# echo -en "${G}*${W} The domain used in the project should be [username].42.fr, but if you don't have \
# root permissions, you cannot modify /etc/hosts and therefore it is advised to set the \
# domain to 'localhost'. \
# ${Y}\nDo you want to set it to 'localhost'?${W} " \
# && read -p "[y/n] " ANSWER;
# if [ "$ANSWER" != 'y' ]; then
#     USER=''
#     while [ -z "$USER" ]
#     do read -p "Domain name (only the username without TLD): " USER; done;
# fi

# datafolder
# echo -en "${G}*${W} Inception needs data persistence, therefore 2 volumes will be mounted on your \
# system. The default folder in which they are mounted is ${G}$DATA${W}.\
# ${Y}\nDo you want to change the path?${W} " \
# && read -p "[y/n] " ANSWER;
# if [ "$ANSWER" = 'y' ]; then
#     DATA=''
#     while [ -z "$DATA" ]
#     do read -p "Data folder (absolute path): " DATA; done;
# fi
# DATA+=/data;

# echo -en "${G}You set:\n\
# * Domain name: $USER\n\
# * Data folder: $DATA\

echo -en "${Y}\nDo you want to continue?${W} " && read -p "[y/n] " ANSWER;
if [ "$ANSWER" != 'y' ]; then
    exit 1;
fi

echo "\
USER=$USER
WP_DOMAIN=$USER.42.fr
WP_DATA=$DATA/wp_data
DB_DATA=$DATA/db_data
DB_SECRETS=/run/secrets/db_secrets
WP_SECRETS=/run/secrets/wp_secrets" > $ENV;

echo "$ENV
$DATA" > ./tools/clean;
