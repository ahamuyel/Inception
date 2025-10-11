FROM debian:12

RUN apt update && apt upgrade && apt install -y nginx openssl netcat-traditional\
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl /var/www/html

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=AO/ST=Luanda/L=Luanda/O=42/CN=ahamuyel.42.fr"

EXPOSE 443

CMD [ "/entrypoint.sh" ]