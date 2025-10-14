COMPOSE_DIR= srcs

DOCKER_COMPOSE = docker compose -f $(COMPOSE_DIR)/docker-compose.yml

DB_VOLUME_PATH = /home/ahamuyel/data/db
WP_VOLUME_PATH = /home/ahamuyel/data/wp

GREEN = \033[1;32m
RED = \033[1;31m
YELLOW = \033[1;33m
NC = \033[0m

all: up

up:
	@echo "$(GREEN)[+] A subir os containers...$(NC)"
	$(DOCKER_COMPOSE) up --build -d

down:
	@echo "$(RED)[-] A parar os containers...$(NC)"
	$(DOCKER_COMPOSE) down --rmi all

logs:
	@echo "$(YELLOW)[*] Logs em tempo real... Pressione Ctrl+C para sair.$(NC)"
	$(DOCKER_COMPOSE) logs -f

ps:
	$(DOCKER_COMPOSE) ps -a

clean: down
	@echo "$(RED)[-] Limpando system prune (imagens órfãs, containers, networks)...$(NC)"
	docker system prune -af --volumes
	docker builder prune -f

volumes:
	@echo "$(RED)[-] Limpando volumes locais de banco de dados e WordPress...$(NC)"
	sudo rm -rf $(DB_VOLUME_PATH)/* || true
	sudo rm -rf $(WP_VOLUME_PATH)/* || true

fclean: clean volumes
	@echo "$(RED)[-] Removendo todos os containers e imagens...$(NC)"
	docker rm -f $$(docker ps -aq) 2>/dev/null || true
	docker rmi -f $$(docker images -aq) 2>/dev/null || true
	docker volume prune -f

re: down all
