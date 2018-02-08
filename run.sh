#!/bin/sh
redis-server &
status=$?

if [ $status -ne 0 ]; then
    echo "Failed to start redis, exiting."
    exit $status
fi

java -jar ./maildrop-master/smtp/target/scala-2.10/smtp-assembly-2.0.jar &
status=$?

if [ $status -ne 0 ]; then
    echo "Failed to start SMTP server, exiting."
    exit $status
fi

