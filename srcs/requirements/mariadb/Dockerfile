FROM debian:12

RUN apt update && apt upgrade && apt install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

RUN sed -i 's/^bind-address/# bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf \
    && echo "bind-address=0.0.0.0" >> /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3306

CMD [ "/init.sh" ]