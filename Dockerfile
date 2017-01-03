FROM armv7/armhf-ubuntu:16.04
RUN apt-get update \
	&& apt-get install -y \
	git \
	netcat \
	python3 \
	python3-pip \
	python3-virtualenv \
	python3-setuptools \
	sox \
	swig \
	iputils-ping \
 	&& rm -rf /var/lib/apt/lists/*

RUN git clone -b python3 git://github.com/bashwork/pymodbus.git \
    && cd pymodbus \
    && python3 setup.py install

COPY ./entrypoint.sh ./requirements.txt /

RUN /usr/bin/pip3 install -r /requirements.txt; rm /requirements.txt

VOLUME ["/opt/facility-management-control-unit"]

WORKDIR "/opt/facility-management-control-unit/source/webservice"

ENV PYTHONPATH="/opt/facility-management-control-unit/source/webservice" SETTINGS_MODULE="settings.base"
ENTRYPOINT ["/entrypoint.sh"]
