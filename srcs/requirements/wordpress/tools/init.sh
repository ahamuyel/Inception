#!/bin/bash

set -e

WP_DIR=/var/www/html

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_user_password)

if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "⬇️ A Baixar o WordPress..."
    curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf wordpress.tar.gz -C /tmp
    cp -r /tmp/wordpress/* $WP_DIR
    rm -rf /tmp/wordpress wordpress.tar.gz

    echo "⚙️ Configurando wp-config.php..."
    cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/" $WP_DIR/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" $WP_DIR/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" $WP_DIR/wp-config.php
    sed -i "s/localhost/mariadb/" $WP_DIR/wp-config.php
fi


# Instalar WordPress se ainda não existir
if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "⬇️ Baixando WordPress..."
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /tmp
    cp -r /tmp/wordpress/* "$WP_DIR"
    rm -rf /tmp/wordpress /tmp/wordpress.tar.gz

    echo "⚙️ Configurando wp-config.php..."
    wp config create \
        --allow-root \
        --path="$WP_DIR" \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="mariadb:3306" \
        --skip-check
fi

# Instalar WordPress automaticamente (caso não esteja instalado)
if ! wp core is-installed --allow-root --path="$WP_DIR"; then
    echo "🚀 Instalando WordPress..."
    wp core install \
        --allow-root \
        --path="$WP_DIR" \
        --url="https://ahamuyel.42.fr" \
        --title="ahamuyel" \
        --admin_user="$DB_USER" \
        --admin_password="$DB_PASSWORD" \
        --admin_email="admin@ahamuyel.42.fr"
fi


chmod -R 755 $WP_DIR
chown -R www-data:www-data $WP_DIR

php-fpm8.2 -F