FROM public.ecr.aws/docker/library/php:8.1-apache

COPY --from=public.ecr.aws/tinystacks/secret-env-vars-wrapper:latest-x86 /opt /opt

COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.3.2-x86_64 /lambda-adapter /opt/extensions/lambda-adapter

WORKDIR /app

ARG PORT=8080

ENV PORT=${PORT}

COPY src /var/www/html/

COPY . .

EXPOSE $PORT

RUN sed -i "s/80/$PORT/g" /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

CMD /opt/tinystacks-secret-env-vars-wrapper docker-php-entrypoint apache2-foreground