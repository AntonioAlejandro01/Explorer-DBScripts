
FROM mysql:8

ENV MYSQL_DATABASE Explorer
ENV MYSQL_ROOT_PASSWORD: explorer
ENV MYSQL_USER explorer
ENV MYSQL_PASSWORD explorer

COPY ./init.sql /
COPY ./run.sh /docker-entrypoint-initdb.d/