FROM nginx:alpine

COPY ./ninjakart /usr/share/nginx/html

RUN chmod +x /usr/share/nginx/html/Build