FROM alpine:3.20

# install nginx and ssl
RUN apk update && apk add --no-cache nginx openssl

# create directory for certificate
RUN mkdir -p /run/nginx/ /etc/nginx/ssl /var/www/html

#create certificate
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
 -out /etc/nginx/ssl/nginx.crt \
 -keyout /etc/nginx/ssl/nginx.key \
 -subj "/C=FI/ST=Helsinki/L=Helsinki/O=42/OU=Hive/CN=${DOMAIN_NAME}"

# Add a new user within the container
RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

# copy nginx cofiguration file into the cotainer
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

# copy script file into the container
COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

# start nginx when the container runs
#CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["/script.sh"]
