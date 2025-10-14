FROM debian:bookworm

RUN apt update && apt install -y nginx openssl netcat-traditional \
   && rm -rf /var/lib/apt/lists/*

COPY tools/entrypoint.sh /entrypoint.sh
COPY conf/default.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /entrypoint.sh

RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=AN/ST=Luanda/L=Luanda/O=42/CN=ahamuyel.42.fr"

EXPOSE 443 

CMD ["/entrypoint.sh"]
