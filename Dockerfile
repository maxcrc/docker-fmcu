FROM armv7/armhf-ubuntu:16.04

ENV DJANGO_LISTEN_PORT=8000 DJANGO_LISTEN_HOST=0.0.0.0 PYTHONPATH="/opt/fmcu/source/webservice/webservice" DJANGO_SETTINGS_MODULE="webservice.settings.dev"

RUN apt-get update && apt-get install -y python3 redis-server python3-pip python3-virtualenv postgresql-server-dev-all

ADD ./requirements.txt /tmp/requirements.txt
RUN /usr/bin/pip3 install -r /tmp/requirements.txt

RUN cd /tmp; \
	git clone https://github.com/hardkernel/WiringPi2-Python.git; \
	cd WiringPi2-Python; \
	git submodule init; \
	git submodule update; \
	/usr/bin/python3 setup.py install; \
	cd -; \
	rm -rf WiringPi2-Python 

VOLUME ["/opt/fmcu"]

EXPOSE $DJANGO_LISTEN_PORT 10072

WORKDIR "/opt/fmcu/source/webservice/webservice"

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
