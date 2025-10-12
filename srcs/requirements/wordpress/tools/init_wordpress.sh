#!/bin/bash
set -e

if [ ! -f "$WP_DIR/wp-config.php" ]; then
    curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf wordpress.tar.gz -C /tmp
    cp -r /tmp/wordpress/* $WP_DIR
    rm -rf /tmp/wordpress wordpress.tar.gz

    cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/" $WP_DIR/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" $WP_DIR/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" $WP_DIR/wp-config.php
    sed -i "s/localhost/mariadb/" $WP_DIR/wp-config.php
fi

chown -R www-data:www-data $WP_DIR

php-fpm8.2 -F