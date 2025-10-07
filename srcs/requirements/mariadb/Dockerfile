FROM debian:12

RUN apt update && apt install -y mariadb-server

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

RUN sed -i 's/^bind-address/# bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf \
    && echo "bind-address=0.0.0.0" >> /etc/mysql/mariadb.conf.d/50-server.cnf
RUN echo "[mysqld]\nbind-address=0.0.0.0" > /etc/mysql/mariadb.conf.d/99-bind.cnf

COPY tools/init_db.sh /init_db.sh

RUN chmod +x /init_db.sh

EXPOSE 3306

CMD [ "/init_db.sh" ]