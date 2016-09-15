#!/bin/bash

set -e

/usr/bin/python3 ../manage.py migrate &
/bin/sleep 10
exec /usr/bin/python3 /opt/fmcu/source/webservice/manage.py runserver $DJANGO_LISTEN_HOST:$DJANGO_LISTEN_PORT
