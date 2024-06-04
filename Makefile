# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ncasteln <ncasteln@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/03 11:37:43 by ncasteln          #+#    #+#              #
#    Updated: 2024/06/04 08:42:51 by ncasteln         ###   ########.fr        #
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
up: check secrets volumes build
	@echo "$(G)* Creating containers...$(W)";
	cd ./srcs/ && docker compose up

build:
	@echo "$(G)* Building the images of each service...$(W)";
	cd ./srcs/ && docker compose build;

down:
	@echo "$(G)* Removing containers...$(W)";
	cd ./srcs/ && docker compose down;

volumes:
	@./create-folders.sh $(DATA_FOLDER)

secrets:
	@./create-credentials.sh

check:
	@echo "$(Y)* Before running inception, consider the followings: ";
	@echo "$(W)- The default user under which inception will be run is $(B)ncasteln$(W), \
	If you want to change it you have to do it manually";
	@echo "- To run inception 2 volumes are needed. A script will do it for you and create them \
	under $(B)$(DATA_FOLDER)/data/$(W). If you want to change it you have to do it manually";
	@echo "- To run it alo 2 files which hold the $(B)credentials$(W) are necessary. A script \
	will help you to create them. Obviously this is just for learning pourpose.";
	@echo "- To see the wordpress correctly page you need to change the $(B)/etc/hosts$(W) file";
	@echo "$(Y)Do you want to continue to make inception? $(W)[y/N] " && read ANSWER && [ $${ANSWER:-N} = y ];

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
volumes reset secrets
