FROM openjdk:alpine
LABEL MAINTAINER "Jan Szumiec <jan.szumiec@gmail.com>"
RUN mkdir /maildrop
WORKDIR /maildrop
COPY dist/* /maildrop/
RUN unzip web-2.0.zip

# redis
RUN apk --update add redis
RUN apk add bash

# Finishing touches
COPY run.sh /maildrop
CMD ./run.sh

EXPOSE 25000
EXPOSE 9000
VOLUME /var/lib/redis
