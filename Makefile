NAME = inceptoin


all: up

up:
	@echo "\033[1;32m[+] Subindo containers...\033[0m"
	cd srcs && docker compose -p $(NAME) up -d --build

down:
	@echo "\033[1;31m[-] Parando containers...\033[0m"
	cd srcs && docker compose -p $(NAME) down

clean: down
	@echo "\033[1;33m[!] Removendo volumes e imagens órfãs...\033[0m"
	docker system prune -af --volumes

ps:
	cd srcs && docker compose -p $(NAME) ps

logs:
	cd srcs && docker compose -p $(NAME) logs -f

restart: down up


re: clean up