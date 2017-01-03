# fmcu

docker run --net="host" --name fmcu -v /opt/fmcu:/opt/fmcu -t -i --privileged -v /dev:/dev -e SETTINGS_MODULE=settings.base -d fmcu
