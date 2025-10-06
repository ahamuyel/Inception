FROM debian:12-slim

RUN apt update && apt install -y nginx openssl

COPY index.html /var/www/html/index.html
COPY default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=AN/ST=Luanda/L=Luanda/O=42/CN=ahamuyel.inception.42.fr"

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]