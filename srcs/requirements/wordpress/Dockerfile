FROM alpine:3.20

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

EXPOSE 9000

RUN mkdir -p /run/php/ /var/www/html

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

COPY ./tools/script.sh /
RUN chmod +x script.sh

ENTRYPOINT ["sh", "/script.sh"]
