FROM armv7/armhf-ubuntu:16.04
RUN apt-get update \
	&& apt-get install -y \
	git \
	libccid \
	libpcsclite-dev\
	libpcsclite1 \
	libsox-fmt-mp3 \
	netcat \
	pcscd \
	python3 \
	python3-pip \
	python3-virtualenv \
	python3-setuptools \
	sox \
	swig \
	iputils-ping \
 	&& rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh ./requirements.txt ./asound.conf /

RUN /usr/bin/pip3 install -r /requirements.txt; rm /requirements.txt

RUN git clone -b python3 git://github.com/bashwork/pymodbus.git \
    && cd pymodbus \
    && python3 setup.py install

RUN cd /tmp; \
	git clone https://github.com/hardkernel/WiringPi2-Python.git; \
	cd WiringPi2-Python; \
	git submodule init; \
	git submodule update; \
	swig3.0 -python -threads wiringpi.i; \
	/usr/bin/python3 setup.py install; \
	cd - \
	&& rm -rf WiringPi2-Python \
	&& apt-get autoremove -y \
	&& apt-get clean -y

VOLUME ["/opt/facility-management-control-unit", "/var/log/fmcu"]

ENV START_PCSCD=0 \
	PORT=8888 \
	PYTHONPATH="/opt/facility-management-control-unit/source/webservice/webservice" \
	SETTINGS="webservice.settings.dev" \
	PCSCD_LOG_PATH="/opt/facility-management-control-unit/source/webservice/webservice/logs/pcscd.log" \
	PCSCD_LOG_LEVEL="error" \
	TZ=Europe/Berlin

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE $PORT
WORKDIR "/opt/facility-management-control-unit/source/webservice"
	
ENTRYPOINT ["/entrypoint.sh"]
