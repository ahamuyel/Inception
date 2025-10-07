#!/bin/bash
set -e

# Inicia temporariamente o MariaDB
mysqld_safe --nowatch

# Espera o servidor ficar pronto
until mariadb-admin ping --silent; do
    sleep 1
done

# Cria base de dados e usuário
mariadb -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

# Para o servidor temporário
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Inicia o servidor real
exec mysqld_safe
