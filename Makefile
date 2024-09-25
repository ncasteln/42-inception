# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nico <nico@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/03 11:37:43 by ncasteln          #+#    #+#              #
#    Updated: 2024/09/25 14:00:21 by nico             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# useful to check all ignored files
# git log --all --full-history -- "**/.env.*"
# find . -type d | grep -v .git | awk '{print $1"/"}' | git check-ignore -v --stdin
# find . -type f | grep -v .git | awk '{print $1"/"}' | git check-ignore -v --stdin

NGINX_DIR			=	./srcs/requirements/nginx
MARIADB_DIR			=	./srcs/requirements/mariadb
WP_DIR				=	./srcs/requirements/wordpress

# --------------------------------------------------------------------- COMPOSE
up: env folders credentials build
	@echo "$(G)* Creating containers...$(W)";
	cd ./srcs/ && docker compose up

env:
	@./tools/create-env.sh

folders:
	@./tools/create-folders.sh || exit 1;

credentials:
	@./tools/create-credentials.sh

build:
	@echo "$(G)* Building the images of each service...$(W)";
	cd ./srcs/ && docker compose build;

down:
	@echo "$(G)* Removing containers...$(W)";
	cd ./srcs/ && docker compose down;

# ----------------------------------------------------------------------- NGINX
nginx:
	cd $(NGINX_DIR) && docker build -t nginx-img ./

nginx-cont: nginx
	@cd $(NGINX_DIR) && docker run --detach --name nginx-cont -p 443:443 nginx-img;
	@if [ $$(docker ps -a --filter "status=running" | grep nginx-cont | wc -l) -ne 0 ]; then \
		echo "$(G)* nginx is running$(W)"; \
	else \
		echo "$(R)* nginx exited$(W)"; \
	fi

# --------------------------------------------------------------------- MARIADB
mariadb:
	@cd $(MARIADB_DIR) && docker build -t mariadb-img ./

mariadb-cont: mariadb
	@cd $(MARIADB_DIR) && docker run --init --detach --name mariadb-cont --publish 3306:3306 mariadb-img;
	@if [ $$(docker ps -a --filter "status=running" | grep mariadb-cont | wc -l) -ne 0 ]; then \
		echo "$(G)* mariadb is running$(W)"; \
	else \
		echo "$(R)* mariadb exited$(W)"; \
	fi

# ------------------------------------------------------------------- WORDPRESS
wp:
	@cd $(WP_DIR) && docker build -t wp-img ./

wp-cont: wp
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

clean-data: #remove folders, .env and secrets
	@./tools/clean-data.sh
	@rm -rf ./tools/clean

fclean: stop clean clean-img clean-vol clean-net clean-data

reset: fclean #reuires sudo privileges
	docker system prune;
	systemctl restart docker;

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
Y	=	\033[0;33m
B	=	\033[0;34m
R	=	\033[0;31m
W	=	\033[0m
N	=	\033[1;30m

.PHONY: nginx nginx-cont stop clean clean-img fclean display mariadb \
mariadb-cont wp wp-cont clean-net clean-vol build up down reset secrets \
clean-data env folders credentials
