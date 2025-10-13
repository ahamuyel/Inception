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

volumes:
	cd /home/ahamuyel/data/db && sudo rm -rf *
	cd /home/ahamuyel/data/wp && sudo rm -rf *

re: clean all
