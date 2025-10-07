FROM debian:12

# Instalar Nginx e OpenSSL
RUN apt update && apt install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

# Criar diretórios necessários
RUN mkdir -p /etc/nginx/ssl /var/www/html

# Copiar arquivos de configuração e conteúdo
COPY index.html /var/www/html/index.html
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Gerar certificado SSL autoassinado
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=AO/ST=Luanda/L=Luanda/O=42/CN=ahamuyel.42.fr"

# Expor porta HTTPS
EXPOSE 443

# USER nginx

# Comando de execução (PID 1 correto)
CMD ["nginx", "-g", "daemon off;"]
