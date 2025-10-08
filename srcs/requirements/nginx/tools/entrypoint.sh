#!/bin/bash
# Espera o WordPress estar pronto
while ! nc -z wordpress 9000; do
  echo "Waiting for WordPress..."
  sleep 1
done

# Inicia o NGINX
nginx -g "daemon off;"
