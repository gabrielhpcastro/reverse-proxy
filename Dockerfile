FROM nginx:alpine

#ENV VARIABLES
ENV PORT=8080

# COPY PUBLIC FILES
COPY public /usr/share/nginx/html

# COPY NGINX CONFIG FILES
COPY nginx/default.conf /etc/nginx/templates/default.conf.template

# COPY SSL CERTIFICATES
COPY ssl/key.pem /etc/nginx/ssl/key.pem
COPY ssl/cert.pem /etc/nginx/ssl/cert.pem

EXPOSE 443