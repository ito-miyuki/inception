FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client bash net-tools

EXPOSE 3306

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

ENTRYPOINT ["sh", "/tmp/script.sh"]

# CMD ["/tmp/script.sh"]
