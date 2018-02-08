FROM bigtruedata/sbt
LABEL MAINTAINER "Jan Szumiec <jan.szumiec@gmail.com>"
RUN mkdir /maildrop
WORKDIR /maildrop
RUN wget -qO- https://github.com/m242/maildrop/archive/master.zip | jar xvf /dev/stdin
WORKDIR /maildrop/maildrop-master/smtp
RUN sbt compile
WORKDIR /maildrop/maildrop-master/web
RUN chmod a+x activator
RUN ./activator dist
