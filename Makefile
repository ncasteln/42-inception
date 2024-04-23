# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ncasteln <ncasteln@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/22 14:22:00 by ncasteln          #+#    #+#              #
#    Updated: 2024/04/23 11:18:39 by ncasteln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NGINX_DIR	=	./srcs/requirements/nginx

MARIADB_DIR	=	./srcs/requirements/mariadb

NULL		= 	>/dev/null

# ----------------------------------------------------------------------- RULES
all: nginx

debian:
	docker build -t debian-img ./
	docker run -it --name debian-cont debian-img

nginx:
	cd $(NGINX_DIR) && docker build -t nginx-img ./

nginx-run:
	@cd $(NGINX_DIR) && docker run -d --name nginx-cont -p 80:80 nginx-img;
# @if [ docker ps -a | grep 'Exited' ]; then \
# 	echo "$(R)nginx exited$(W)"; \
# else \
# 	echo "$(G)nginx is running$(W)"; \
# fi

nginx-it:
	@cd $(NGINX_DIR) && docker run -it --name nginx-cont -p 80:80 nginx-img;

# ----------------------------------------------------------------------- CLEAN
stop:
	@if [ $$(docker ps -a --filter "status=exited" | wc -l) -eq 1 ]; then \
		echo "$(R)Nothing to stop$(W)"; \
	else \
		docker stop $$(docker ps -aq); \
		echo "$(G)Containers stopped$(W)"; \
	fi

clean: stop
	@if [ $$(docker ps -a | wc -l) -eq 1 ]; then \
		echo "$(R)No containers to remove$(W)"; \
	else \
		docker rm $$(docker ps -aq); \
		echo "$(G)All containers removed$(W)"; \
	fi

clean-img: clean
	@if [ $$(docker images -a | wc -l) -eq 1 ]; then \
		echo "$(R)No images to remove$(W)"; \
	else \
		docker rmi -f $$(docker images -aq); \
		echo "$(G)All images removed$(W)"; \
	fi

fclean: clean-img

re: clean-img clean all

# ----------------------------------------------------------------------- UTILS
display:
	@docker ps -a
	@echo $(SEP);
	@docker images -a

R	=	\033[0;31m
G	=	\033[0;32m
B	=	\033[0;34m
W	=	\033[0m
SEP	=	"------------------------------------------------------------------"

.PHONY: all nginx