NAME = inception

COMPOSE_FILE = srcs/docker-compose.yml

# ======================= #
#        COMMANDS         #
# ======================= #

all: up

up:
	@echo "\033[1;32m[+] Subindo containers...\033[0m"
	cd srcs && docker compose up -d --build

down:
	@echo "\033[1;31m[-] Parando containers...\033[0m"
	cd srcs && docker compose down

ps:
	cd srcs && docker compose ps

logs:
	cd srcs && docker compose logs -f

clean: down
	@echo "\033[1;33m[!] Removendo volumes e imagens órfãs...\033[0m"
	docker system prune -af --volumes

restart: down up
re: clean up

.PHONY: all up down restart ps logs clean re
