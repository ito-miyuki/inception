FROM alpine:3.20

#RUN apk update && apk add --no-cache \
#    php81 php81-phar php81-curl php81-fpm php81-mysqli php81-mbstring \
#    php81-json php81-gd php81-xml php81-zip mariadb-client curl tar bash

# crete wordpress directory
#RUN mkdir -p /var/www/html

#download wordpress
#RUN curl -o /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz && \
#    tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 && \
#    rm /tmp/latest.tar.gz

#EXPORT 9000

#install wp-cli
#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/wp-cli.phar && \
#    chmod +x wp-cli.phar && \
#    mv wp-cli.phar /usr/local/bin/wp

#COPY ./tools/script.sh /
#RUN chmod +x /script.sh

#CMD ["/script.sh"]


# Create user nginx and add to primary and secondary group nginx (create if it doesn't exist)
RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

RUN apk update && apk add --no-cache \
	php83 \
	php83-phar \
	php83-curl \
	php83-fpm \
	php83-mysqli \
	php83-mbstring \
	php83-json \
	php83-gd \
	php83-xml \
	php83-zip \
	mariadb-client

# Listening port
EXPOSE 9000

# Create a symlink for `php`
#RUN ln -s /usr/bin/php83 /usr/bin/php

# Create and copy paths and confs to cont
RUN mkdir -p /run/php/ /var/www/html

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

COPY ./tools/script.sh /
RUN chmod +x script.sh

CMD ["/script.sh"]
