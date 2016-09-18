FROM armv7/armhf-ubuntu:16.04

ENV DJANGO_LISTEN_PORT=8000 DJANGO_LISTEN_HOST=0.0.0.0 PYTHONPATH="/opt/facility-management-control-unit/source/webservice/webservice" DJANGO_SETTINGS_MODULE="webservice.settings.dev"

COPY ./entrypoint.sh ./requirements.txt ./asound.conf /

RUN apt-get update \
	&& apt-get install -y \
	git \
	libsox-fmt-mp3 \
	netcat \
	postgresql-server-dev-all \
	python3 \
	python3-pip \
	python3-virtualenv \
	redis-server \
	sox \
 	&& rm -rf /var/lib/apt/lists/*

RUN /usr/bin/pip3 install -r /requirements.txt; rm /requirements.txt

RUN cd /tmp; \
	git clone https://github.com/hardkernel/WiringPi2-Python.git; \
	cd WiringPi2-Python; \
	git submodule init; \
	git submodule update; \
	/usr/bin/python3 setup.py install; \
	cd - \
	&& rm -rf WiringPi2-Python \
	&& apt-get remove --purge git -y \
	&& apt-get autoremove -y \
	&& apt-get clean -y

VOLUME ["/opt/facility-management-control-unit"]

EXPOSE $DJANGO_LISTEN_PORT 10072
WORKDIR "/opt/facility-management-control-unit/source/webservice/webservice"
ENTRYPOINT ["/entrypoint.sh"]
