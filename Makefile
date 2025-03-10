DOMAIN_NAME = mito.42.fr
DATA_DIR = /home/mito/data
DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	@if ! grep -q "$(DOMAIN_NAME)" /etc/hosts; then \
		echo "127.0.0.1 $(DOMAIN_NAME)" | sudo tee -a /etc/hosts > /dev/null; \
	fi
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress
	$(DOCKER_COMPOSE) up --build -d
	
clean:
	$(DOCKER_COMPOSE) down --rmi all -v

fclean: clean
	sudo rm -rf $(DATA_DIR)/mariadb
	sudo rm -rf $(DATA_DIR)/wordpress
	docker system prune -f

re: fclean all

up:
	$(DOCKER_COMPOSE) up --build -d

down:
	$(DOCKER_COMPOSE) down

.PHONY: all clean fclean re up down
