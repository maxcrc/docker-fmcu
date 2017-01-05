# fmcu

docker run --restart=always --name fmcu -v /opt/facility-management-control-unit:/opt/facility-management-control-unit -v /var/lib/fmcu:/root/fmcu -t -i --privileged -v /dev:/dev -e SETTINGS_MODULE=settings.barnet.dev-upstairs -p 80:8888 -d maxcrc/fmcu
