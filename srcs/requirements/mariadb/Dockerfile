FROM debian:12

RUN apt update && apt install -y mariadb-server

# Copiar script de inicialização
COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

EXPOSE 3306

CMD [ "mysqld_safe" ]
