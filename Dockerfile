FROM nginx:alpine

#ENV VARIABLES
ENV PORT=8080

# COPY PUBLIC FILES
COPY public /usr/share/nginx/html

# COPY NGINX CONFIG FILES
COPY nginx/default.conf /etc/nginx/conf.d

# COPY SSL CERTIFICATES
COPY ssl/key.pem /etc/nginx/ssl/key.pem
COPY ssl/cert.pem /etc/nginx/ssl/cert.pem

# REPLACE ENV VARIABLES IN CONFIG FILE
CMD ['envsubst < /etc/nginx/conf.d/default.conf', 'nginx -g \'daemon off;\'']

EXPOSE 443