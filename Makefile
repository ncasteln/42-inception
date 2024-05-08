# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ncasteln <ncasteln@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/22 14:22:00 by ncasteln          #+#    #+#              #
#    Updated: 2024/05/08 12:52:03 by ncasteln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NGINX_DIR	=	./srcs/requirements/nginx
MARIADB_DIR	=	./srcs/requirements/mariadb
WP_DIR		=	./srcs/requirements/wordpress

NULL		= 	>/dev/null

all: nginx mariadb

debian:
	cd ./srcs/requirements/debian && docker build -t debian-img ./
	docker run \
		--interactive \
		--tty \
		--name debian-cont \
		--publish 3306:3306 \
		debian-img

# ----------------------------------------------------------------------- NGINX
nginx:
	cd $(NGINX_DIR) && docker build -t nginx-img ./

nginx-run: nginx
	@cd $(NGINX_DIR) && docker run --detach --name nginx-cont -p 443:443 nginx-img;
	@if [ $$(docker ps -a --filter "status=running" | grep nginx-cont | wc -l) -ne 0 ]; then \
		echo "$(G)* nginx is running$(W)"; \
	else \
		echo "$(R)* nginx exited$(W)"; \
	fi

# --------------------------------------------------------------------- MARIADB
mariadb:
	@cd $(MARIADB_DIR) && docker build -t mariadb-img ./

mariadb-run: mariadb
	@cd $(MARIADB_DIR) && docker run --init --detach --name mariadb-cont mariadb-img;
	@if [ $$(docker ps -a --filter "status=running" | grep mariadb-cont | wc -l) -ne 0 ]; then \
		echo "$(G)* mariadb is running$(W)"; \
	else \
		echo "$(R)* mariadb exited$(W)"; \
	fi

# ------------------------------------------------------------------- WORDPRESS
wp:
	@cd $(WP_DIR) && docker build -t wp-img ./

wp-run: wp
	@cd $(MARIADB_DIR) && docker run --init -it --name wp-cont -p 9000:9000 wp-img;
	@if [ $$(docker ps -a --filter "status=running" | grep wp-cont | wc -l) -ne 0 ]; then \
		echo "$(G)* wp is running$(W)"; \
	else \
		echo "$(R)* wp exited$(W)"; \
	fi

# ----------------------------------------------------------------------- CLEAN
stop:
	@if [ $$(docker ps -a --quiet --filter "status=running" | wc -l) -ge 1 ]; then \
		docker stop $$(docker ps -a --quiet); \
		echo "$(G)* Containers stopped$(W)"; \
	else \
		echo "$(N)* Nothing to stop$(W)"; \
	fi

clean:
	@if [ $$(docker ps -a --quiet | wc -l) -ge 1 ]; then \
		docker rm $$(docker ps -a --quiet); \
		echo "$(G)* All containers removed$(W)"; \
	else \
		echo "$(N)* No containers to remove$(W)"; \
	fi

clean-img:
	@if [ $$(docker images -a --quiet | wc -l) -ge 1 ]; then \
		docker rmi -f $$(docker images -a --quiet); \
		echo "$(G)* All images removed$(W)"; \
	else \
		echo "$(N)* No images to remove$(W)"; \
	fi

clean-vol:
	@if [ $$(docker volume ls --quiet | wc -l) -ge 1 ]; then \
		docker volume rm $$(docker volume ls --quiet); \
		echo "$(G)* All volumes removed$(W)"; \
	else \
		echo "$(N)* No volumes to remove$(W)"; \
	fi

clean-net:
	@if [ $$(docker network ls --quiet | wc -l) -gt 3 ]; then \
		docker network rm $$(docker network ls --quiet); \
		echo "$(G)* All custom networks removed$(W)"; \
	else \
		echo "$(N)* No custom networks to remove$(W)"; \
	fi

fclean: stop clean clean-img clean-vol clean-net
# @docker builder prune

pclean: stop #prompt clean
	@docker container prune
	@docker image prune
	@docker volume prune
	@docker network prune
	@docker builder prune

re: fclean all

# ----------------------------------------------------------------------- UTILS
display:
	@echo "$(B)------------------------ IMAGES ------------------------$(W)";
	@if [ $$(docker images -a --quiet | wc -l) -ge 1 ]; then \
		docker images -a; \
	else \
		echo "$(N)* No images to display$(W)"; \
	fi

	@echo "$(B)---------------------- CONTAINERS ----------------------$(W)";
	@if [ $$(docker ps -a --quiet | wc -l) -ge 1 ]; then \
		docker ps -a; \
	else \
		echo "$(N)* No containers to display$(W)"; \
	fi

	@echo "$(B)------------------------ VOLUMES -----------------------$(W)";
	@if [ $$(docker volume list | wc -l) -gt 1 ]; then \
		docker volume list; \
	else \
		echo "$(N)* No volumes to display$(W)"; \
	fi

	@echo "$(B)------------------------ NETWORKS ----------------------$(W)";
	@if [ $$(docker network list | wc -l) -gt 1 ]; then \
		docker network list; \
	else \
		echo "$(N)* No networks to display$(W)"; \
	fi

G	=	\033[0;32m
B	=	\033[0;34m
R	=	\033[0;31m
W	=	\033[0m
N	=	\033[1;30m
SEP	=	"------------------------------------------------------------------"

.PHONY: all debian nginx nginx-run stop clean clean-img fclean re display \
mariadb mariadb-run  wp wp-run hclean clean-net clean-vol pclean