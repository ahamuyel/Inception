FROM debian:12

RUN apt update && apt upgrade && apt install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysqli \
    php8.2-pdo \
    php8.2-mysql \
    php8.2-zip \
    mariadb-client \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html /run/php

COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY /tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

CMD [ "/init.sh" ]