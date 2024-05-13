#!/bin/bash

apt-get update -y && apt-get upgrade -y

if [ "${HELLO}" == "WORLD" ]; then
    apt-get install nano -y
fi
