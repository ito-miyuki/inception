FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client

# other containers can connect to Mariadb to this port
EXPOSE 3306

# copy the mariadb configuration file into the container
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb-server.cnf

# copy the script into container and make it executable
COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# excute script.sh when the container starts
CMD ["/tmp/script.sh"]
