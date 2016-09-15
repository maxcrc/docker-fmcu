FROM armv7/armhf-ubuntu:16.04

ENV DJANGO_LISTEN_PORT 8000
ENV DJANGO_LISTEN_HOST 0.0.0.0

RUN apt-get update
RUN apt-get install -y python3 redis-server python3-pip python3-virtualenv postgresql-server-dev-all

ADD ./requirements.txt /tmp/requirements.txt

VOLUME ["/opt/fmcu"]

RUN /usr/bin/pip3 install -r /tmp/requirements.txt

EXPOSE $DJANGO_LISTEN_PORT

ENV PYTHONPATH="/opt/fmcu/source/webservice/webservice"
ENV DJANGO_SETTINGS_MODULE="webservice.settings.dev"

WORKDIR "/opt/fmcu/source/webservice/webservice"

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
