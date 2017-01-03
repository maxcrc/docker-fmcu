# fmcu

docker run --net="host" --name fmcu -v /opt/fmcu:/opt/fmcu -t -i --privileged -v /dev:/dev -e LISTEN_PORT=80 -d fmcu
