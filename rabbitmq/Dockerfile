ARG RABBITMQ_VERSION=3.9-management-alpine

FROM rabbitmq:${RABBITMQ_VERSION}

LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

RUN rabbitmq-plugins enable --offline rabbitmq_management

EXPOSE 4369 5671 5672 15671 15672 25672
