# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ncasteln <ncasteln@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/03 11:37:43 by ncasteln          #+#    #+#              #
#    Updated: 2024/06/03 13:00:27 by ncasteln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# useful to check all ignored files
# git log --all --full-history -- "**/.env.*"
# find . -type d | grep -v .git | awk '{print $1"/"}' | git check-ignore -v --stdin
# find . -type f | grep -v .git | awk '{print $1"/"}' | git check-ignore -v --stdin

DATA_FOLDER			=	/home/ncasteln
NGINX_DIR			=	./srcs/requirements/nginx
MARIADB_DIR			=	./srcs/requirements/mariadb
WP_DIR				=	./srcs/requirements/wordpress

# --------------------------------------------------------------------- COMPOSE
up: build
	@echo "$(G)* Creating containers...$(W)";
	cd ./srcs/ && docker compose up

build: check volume
	@echo "$(G)* Building the images of each service...$(W)";
	cd ./srcs/ && docker compose build;

down:
	@echo "$(G)* Removing containers...$(W)";
	cd ./srcs/ && docker compose down;

volume:
	@if [[ -d $(DATA_FOLDER)/data/wp_data || -d $(DATA_FOLDER)/data/db_data ]]; then \
		echo "$(Y)* Volume folders already present in /home/ncasteln. Do you want to continue? $(W) [y/n]" && read VOL_ANSWER; \
		if [[ $$VOL_ANSWER != "y" ]]; then \
			echo "$(R)* Do you want to reset the data? [ATTENTION!] This action will erase all the related data:\n - The folders: $(DATA_FOLDER)/data/wp_data and $(DATA_FOLDER)/data/db_data;\n - The volumes: wp_nginx_vol and mariadb_vol $(W) [y/n]" && read RM_ANSWER; \
			if [[ $$RM_ANSWER == "y" ]]; then \
				echo "$(G)* Removing pre-existing data volumes...$(W)"; \
				if [ $$(docker volume ls | wc -l) -ge 1 ]; then \
					docker volume rm mariadb_vol; \
					docker volume rm wp_nginx_vol; \
				fi; \
				echo "$(G)* Removing pre-existing data folders...$(W)"; \
				rm -rd $(DATA_FOLDER)/data/wp_data $(DATA_FOLDER)/data/db_data; \
			fi; \
		fi; \
	else \
		echo "$(G)* Creating volume folder in $(DATA_FOLDER)/data/...$(W)"; \
		mkdir -p $(DATA_FOLDER)/data/wp_data $(DATA_FOLDER)/data/db_data; \
	fi;

secrets:
	@./create-env.sh

check:
	@echo "$(R)* Before running inception, make sure consider the followings: ";
	@echo "- The default user under which inception will be run is ncasteln, \
	if you want to change it you have to do it manually";
	@echo "- By running inception 2 volumes will be created and mounted at $(DATA_FOLDER)/data/, \
	if you want to change it you have to do it manually in this Makefile and in docker-compose.yml";
	@echo "- You need to create 2 files to hold the variables needed by mariadb and wordpress \
	(run make file to pre-compile the 2 .env file, complete them and move into the specified folder)";
	@echo "- To see the wordpress page you need to change the /etc/hosts file";
	@echo "Do you want to continue to make inception? $(W)[y/N] " && read ANSWER && [ $${ANSWER:-N} = y ];

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

fclean: stop clean clean-img clean-vol clean-net
	@rm -rfd $(DATA_FOLDER)/data/

reset: fclean
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
SEP	=	"------------------------------------------------------------------"

.PHONY: nginx nginx-cont stop clean clean-img fclean display \
mariadb mariadb-cont wp wp-cont clean-net clean-vol build up down check \
volume reset secrets
