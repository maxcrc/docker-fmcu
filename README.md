# fmcu

docker run --net="host" --name fmcu -v /opt/fmcu:/opt/fmcu -t -i --privileged -v /dev:/dev -d fmcu
docker run --net="host" -e DJANGO_LISTEN_PORT="8001" -e DJANGO_SETTINGS_MODULE="webservice.settings.remote" --name fmcu-remote -v /opt/fmcu:/opt/fmcu -t -i --privileged -v /dev:/dev -d fmcu
