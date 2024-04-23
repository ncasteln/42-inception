# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ncasteln <ncasteln@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/22 14:22:00 by ncasteln          #+#    #+#              #
#    Updated: 2024/04/23 16:06:12 by ncasteln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NGINX_DIR	=	./srcs/requirements/nginx

MARIADB_DIR	=	./srcs/requirements/mariadb

NULL		= 	>/dev/null

all: nginx mariadb

debian:
	cd ./srcs/requirements/debian && docker build -t debian-img ./
	docker run -it --name debian-cont debian-img

# ----------------------------------------------------------------------- NGINX
nginx:
	cd $(NGINX_DIR) && docker build -t nginx-img ./

nginx-run: nginx
	@cd $(NGINX_DIR) && docker run -d --name nginx-cont -p 80:80 nginx-img;
	@if [ $$(docker ps -a --filter "status=running" | grep nginx-cont | wc -l) -ne 0 ]; then \
		echo "$(G)* nginx is running$(W)"; \
	else \
		echo "$(R)* nginx exited$(W)"; \
	fi

# --------------------------------------------------------------------- MARIADB
mariadb:
	@cd $(MARIADB_DIR) && docker build -t mariadb-img ./

mariadb-run: mariadb
	@cd $(MARIADB_DIR) && docker run -d --name mariadb-cont mariadb-img;
	@if [ $$(docker ps -a --filter "status=running" | grep mariadb-cont | wc -l) -ne 0 ]; then \
		echo "$(G)* mariadb is running$(W)"; \
	else \
		echo "$(R)* mariadb exited$(W)"; \
	fi

# ----------------------------------------------------------------------- CLEAN
# -q flag, suppress the header when listing
stop:
	@if [ $$(docker ps -aq --filter "status=running" | wc -l) -ge 1 ]; then \
		docker stop $$(docker ps -aq); \
		echo "$(G)* Containers stopped$(W)"; \
	else \
		echo "$(R)* Nothing to stop$(W)"; \
	fi

clean: stop
	@if [ $$(docker ps -aq | wc -l) -ge 1 ]; then \
		docker rm $$(docker ps -aq); \
		echo "$(G)* All containers removed$(W)"; \
	else \
		echo "$(R)* No containers to remove$(W)"; \
	fi

clean-img: clean
	@if [ $$(docker images -aq | wc -l) -ge 1 ]; then \
		docker rmi -f $$(docker images -aq); \
		echo "$(G)* All images removed$(W)"; \
	else \
		echo "$(R)* No images to remove$(W)"; \
	fi

fclean: clean-img

re: clean-img clean all

# ----------------------------------------------------------------------- UTILS
display:
	@if [ $$(docker images -aq | wc -l) -ge 1 ]; then \
		docker images -a; \
	else \
		echo "$(B)* No images to display$(W)"; \
	fi
	@echo $(SEP);
	@if [ $$(docker ps -aq | wc -l) -ge 1 ]; then \
		docker ps -a; \
	else \
		echo "$(B)* No containers to display$(W)"; \
	fi

G	=	\033[0;32m
B	=	\033[0;34m
R	=	\033[0;31m
W	=	\033[0m
SEP	=	"------------------------------------------------------------------"

.PHONY: all debian nginx nginx-run stop clean clean-img fclean re display mariadb mariadb-run