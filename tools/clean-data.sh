#!/bin/bash

G="\033[0;32m";
Y="\033[0;33m";
R="\033[0;31m";
W="\033[0m";

FILE=./tools/clean;

while IFS= read -r line
do
    echo -e "${R}* Removing $line.${W}";
done < "$FILE"
echo -en "${Y}Do you want to continue? This action is irreversible!${W} " && read -p "[y/n] " ANSWER;

if [ "$ANSWER" = "y" ]; then
    while IFS= read -r line
    do
        rm -rf $line;
    done < "$FILE"
fi
