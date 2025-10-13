#!/bin/bash

set -e

echo "🚀 Iniciando processo de configuração do MariaDB..."

mysqld_safe --datadir=/var/lib/mysql &
echo "⏳ Aguardando o MariaDB iniciar..."

for i in {1..42}; do
    if mysqladmin ping -h "localhost" --silent; then
        echo "✅ MariaDB está ativo."
        break
    fi
    echo "⏳ Tentativa $i/30... aguardando MariaDB"
    sleep 2
done

if ! mysqladmin ping -h "localhost" --silent; then
   echo "❌ Falha ao iniciar o MariaDB após múltiplas tentativas."
    exit 1
fi

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "🛠️ Inicializando base de dados..."

    mysql -uroot <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;

        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
    echo "✅ Banco de dados '${MYSQL_DATABASE}' e usuário '${MYSQL_USER}' configurados com sucesso."
else
        echo "📂 Banco '${MYSQL_DATABASE}' já existe — pulando inicialização."
fi

echo "🧹 Encerrando instância temporária..."
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

echo "🏁 Iniciando MariaDB em modo foreground..."
exec mysqld_safe --datadir=/var/lib/mysql