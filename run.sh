#!/bin/sh
redis-server &
status=$?

if [ $status -ne 0 ]; then
    echo "Failed to start redis, exiting."
    exit $status
fi

java -jar /maildrop/smtp-assembly-2.0.jar &
status=$?

if [ $status -ne 0 ]; then
    echo "Failed to start SMTP server, exiting."
    exit $status
fi

cd /maildrop/web-2.0/bin
./web

