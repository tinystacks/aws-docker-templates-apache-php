FROM php:8.1.3-apache

EXPOSE 80

COPY src/ /var/www/html/

