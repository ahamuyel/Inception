# Inception

<!-- para printar o ip do container do nginx -->
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx
