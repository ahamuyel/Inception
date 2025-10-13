#!/bin/bash

while ! nc -z wordpress 9000; do 
    echo "⏳ A esperar pelo wordpress..."
    sleep 1
done

exec nginx -g "daemon off;"