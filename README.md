# 42-inception
## Steps
The following are the general step to follow for the project. The approach I use is to learn first the basics of Docker and then create each container separately in the order that I wrote them.

### 0 - Docker  
_Theory_
- Learn basics of Dockerfile, docker CLI, volumes, networks, secrets
- Check about (PID1)[https://cloud.google.com/architecture/best-practices-for-building-containers#signal-handling]

_Practice_
- Experiment containers and automate operations with Makefile
- Create a ready-to-use debian container with sudo priviledges
- Try docker-compose

### 1 - nginx
_Theory_
- What is nginx, TLS, SSL
- Learn basics of nginx configuration  

_Practice_
- Serve a simple html on port 80
- Listen to 443 with SSL

### 2 - wordpress
_Theory_
- What is wordpress, php-fpm

_Practice_
- Two users, one is the administrator (and has to respect password policy)

### 3 - mariadb
_Theory_
- What is mariadb

_Practice_

### 4 - docker compose

### 5 - virtual machine
_Theory_
- Difference/similarities between Docker & VM

_Practice_
- CHange the domain name