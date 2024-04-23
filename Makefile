# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ncasteln <ncasteln@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/22 14:22:00 by ncasteln          #+#    #+#              #
#    Updated: 2024/04/22 15:11:53 by ncasteln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NGINX_DIR	=	./srcs/requirements/nginx

MARIADB_DIR	=	./srcs/requirements/mariadb

NULL		= 	>/dev/null



all: nginx

nginx:
	cd $(NGINX_DIR) && docker build -t nginx-img ./

run-nginx:
	@cd $(NGINX_DIR) && docker run -d --name nginx-cont nginx-img;
	@if docker ps -a | grep 'Exited'; then \
		echo "$(R)nginx exited$(W)"; \
	else \
		echo "$(G)nginx is running"$(W); \
	fi

clean:
	docker stop nginx-cont
	docker rm nginx-cont

R	=	\033[0;31m
G	=	\033[0;32m
B	=	\033[0;34m
W	=	\033[0m

.PHONY: all nginx