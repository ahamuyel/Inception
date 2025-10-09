# Base: Debian
FROM php:8.2-fpm

# Instalar extensões necessárias para WordPress + MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-client \
    libzip-dev \
    unzip \
    curl \
    && docker-php-ext-install mysqli pdo_mysql zip

# Criar diretório do WordPress
RUN mkdir -p /var/www/html

# Copiar configuração PHP-FPM
COPY conf/www.conf /usr/local/etc/php-fpm.d/www.conf

# Copiar script de inicialização
COPY tools/init_wordpress.sh /init_wordpress.sh
RUN chmod +x /init_wordpress.sh

# Expor porta do PHP-FPM (Nginx vai se conectar aqui)
EXPOSE 9000

# Executar o script de inicialização
CMD ["/init_wordpress.sh"]
