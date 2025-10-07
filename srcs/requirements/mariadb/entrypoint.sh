#!/bin/bash
set -e  # Sai em erro para evitar estados inconsistentes

# Função para aguardar o MySQL estar pronto (opcional, para debugging)
# wait_for_mysql() {
#     for i in {30..0}; do
#         if echo 'SELECT 1' | mysql -u root -p"$MYSQL_ROOT_PASSWORD" &> /dev/null; then
#             echo "MySQL pronto!"
#             return 0
#         fi
#         sleep 1
#     done
#     echo "MySQL não iniciou em 30s"
#     exit 1
# }

# Inicializar se necessário (só na primeira run)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "=> Inicializando banco de dados MariaDB pela primeira vez..."

    # Instalar envsubst se não existir (para substituir vars no init.sql)
    if ! command -v envsubst >/dev/null 2>&1; then
        apt update && apt install -y gettext-base && rm -rf /var/lib/apt/lists/*
    fi

    # Substituir vars no init.sql e rodar
    envsubst < /docker-entrypoint-initdb.d/init.sql | mysql -u root -p"$MYSQL_ROOT_PASSWORD"

    echo "=> Inicialização concluída!"
else
    echo "=> Usando banco de dados existente."
fi

# Iniciar mysqld em foreground (PID 1)
exec mysqld --user=mysql --bind-address=0.0.0.0