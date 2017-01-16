#!/bin/bash

if [[ $1 == 'waitfor' ]]; then
	shift
	[ -z ${1+x} ] || [ -z ${2+x} ] && echo -e 'Not enough arguments.\nwaitfor <HOST> <PORT>\n' && exit 1
	HOST=$1
	PORT=$2
	COUNTER=60
	echo -n "Waiting ${COUNTER} seconds for service on ${HOST}:${PORT}"
	while ! nc -q 1 ${HOST} ${PORT} </dev/null; do
		echo -n '.'
		sleep 1;
		COUNTER=$((COUNTER - 1));[ $COUNTER -le 0 ] && echo "Timeout reached." && exit 2
	done
	echo -e "\nService is up."
elif [[ $1 == 'shell' ]]; then
	shift
    exec /bin/bash
fi

mv /asound.conf /etc/

#Doing this because of hanging manage,py
/usr/bin/python3 ../manage.py migrate & PID=$!
sleep 10; kill -9 $PID


# Start pcscd.
# Try 10 times. 
if [ ! -z $START_PCSCD ] && [ $START_PCSCD -ge 1 ]
then
    ATTEMPT=0
    ATTEMPTS=10
    STARTED=false
    echo "pcscd. Starting pcscd service."

    while [ $ATTEMPT -le $ATTEMPTS ]
    do
	echo "Attempt ${ATTEMPT}/${ATTEMPTS}"
	pcscd --"${PCSCD_LOG_LEVEL}" --foreground &>"${PCSCD_LOG_PATH}" &
	sleep 1
	
	if pgrep -x pcscd > /dev/null
	then
	    echo "pcscd. Started."
	    STARTED=true
	    break
	fi

	ATTEMPT=$((ATTEMPT + 1))
    done

    if  [ $STARTED == false ]
    then
	echo "pcscd. Cannot start pcscd exiting."
	exit 1
    fi
fi

exec /usr/bin/python3 ../manage.py runserver $DJANGO_LISTEN_HOST:$DJANGO_LISTEN_PORT
