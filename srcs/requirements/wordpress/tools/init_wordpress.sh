#!/bin/bash
set -e

# Variáveis do .env
WP_DIR=/var/www/html

# Baixar WordPress se não existir
if [ ! -f "$WP_DIR/wp-config.php" ]; then
    curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf wordpress.tar.gz -C /tmp
    cp -r /tmp/wordpress/* $WP_DIR
    rm -rf /tmp/wordpress wordpress.tar.gz

    # Criar wp-config.php usando variáveis do .env
    cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/" $WP_DIR/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" $WP_DIR/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" $WP_DIR/wp-config.php
    sed -i "s/localhost/mariadb/" $WP_DIR/wp-config.php
fi

# Permissões corretas
chown -R www-data:www-data $WP_DIR

# Iniciar PHP-FPM
php-fpm
