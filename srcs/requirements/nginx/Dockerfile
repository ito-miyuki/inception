FROM alpine:3.18

RUN apk update && apk add --no-cache nginx openssl

# create certificate directory
RUN mkdir -p /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/http.d/nginx.conf

# delete/modify this line, it's a temporary solution while word press is not created
RUN mkdir -p /var/www/html && echo '<h1>This is temporary!!!</h1>' > /var/www/html/index.html
COPY tools/script.sh /script.sh
RUN chmod +x /script.sh && /script.sh

CMD ["nginx", "-g", "daemon off;"]
