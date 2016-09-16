#!/bin/bash


if [[ $# > 0 ]]; then
    exec $@
fi

/usr/bin/python3 ../manage.py migrate &
MANAGE_PID=$!
/bin/sleep 10
kill $MANAGE_PID

exec /usr/bin/python3 /opt/fmcu/source/webservice/manage.py runserver $DJANGO_LISTEN_HOST:$DJANGO_LISTEN_PORT
