#!/bin/bash
set -e

# Iniciar MariaDB em background
mysqld_safe --datadir=/var/lib/mysql &

# Esperar o servidor subir
until mysqladmin ping -h "localhost" --silent; do
    echo "Aguardando o MariaDB iniciar..."
    sleep 2
done

# Se o banco ainda não foi inicializado
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Inicializando base de dados..."

    mysql -u root <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
else
    echo "Banco já existente. Pulando inicialização."
fi

# Parar background e iniciar foreground
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
exec mysqld_safe --datadir=/var/lib/mysql
