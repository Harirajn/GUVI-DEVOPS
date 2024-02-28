FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf

COPY html /var/opt/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]