FROM bigtruedata/sbt
LABEL MAINTAINER "Jan Szumiec <jan.szumiec@gmail.com>"
RUN mkdir /maildrop
WORKDIR /maildrop
RUN wget -qO- https://github.com/m242/maildrop/archive/master.zip | jar xvf /dev/stdin
WORKDIR /maildrop/maildrop-master/smtp
RUN echo 'addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.13.0")' > project/assembly.sbt
RUN sbt assembly
WORKDIR /maildrop/maildrop-master/web
RUN echo 'addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.13.0")' > project/assembly.sbt
RUN chmod a+x activator && ./activator dist
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
