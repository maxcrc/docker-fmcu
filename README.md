# fmcu

docker run --restart=always --name fmcu -v /opt/fmcu:/opt/fmcu -v /var/lib/fmcu:/var/lib/fmcu -v /var/log:/var/log -t -i --privileged -v /dev:/dev -e SETTINGS_MODULE=settings.base -d maxcrc/fmcu
