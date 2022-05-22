#!/usr/bin/env sh
docker stop $(docker ps -a |  grep shell_cash_container:1 | awk '{print $1}' )
docker rm $(docker ps -a |  grep shell_cash_container:1 | awk '{print $1}' )
docker build -t shell_cash_container:1 . --network host
docker run --net=host -it -e proxy='http://example.com' --user root --privileged --name shell_clash shell_cash_container:1