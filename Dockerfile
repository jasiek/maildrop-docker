FROM bigtruedata/sbt
LABEL MAINTAINER "Jan Szumiec <jan.szumiec@gmail.com>"
RUN mkdir /maildrop
WORKDIR /maildrop
COPY vendor/maildrop /maildrop/maildrop-master
WORKDIR /maildrop/maildrop-master/smtp
RUN sbt
RUN sbt assembly
WORKDIR /maildrop/maildrop-master/web
RUN chmod a+x activator
RUN ./activator dist
WORKDIR /maildrop

# redis
RUN apt-get update
RUN apt-get install -y redis-server

# Finishing touches
COPY run.sh /maildrop
CMD ./run.sh

EXPOSE 25000
EXPOSE 9000
VOLUME /var/lib/redis
