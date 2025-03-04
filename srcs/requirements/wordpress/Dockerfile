FROM alpine:3.18

RUN apk update && apk add --no-cache \
    php81 php81-phar php81-curl php81-fpm php81-mysqli php81-mbstring \
    php81-json php81-gd php81-xml php81-zip mariadb-client curl tar bash

#download wordpress
RUN curl -o /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf /temp/latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/latest.tar.gz

#install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/wp-cli.phar
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/setup.sh /
RUN chmod +x /setup.sh

CMD ["/setup.sh"] 
