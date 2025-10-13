DOCKER= cd srcs && docker compose

all: up

up:
	$(DOCKER) up --build -d

logs:
	$(DOCKER) logs -f

ps:
	$(DOCKER) ps -a

clean:
	$(DOCKER) down --rmi all

re: clean all
