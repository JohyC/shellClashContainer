#!/usr/bin/env sh
podman stop $(podman ps -a |  grep shell_cash_container:1 | awk '{print $1}' )
podman rm $(podman ps -a |  grep shell_cash_container:1 | awk '{print $1}' )
podman build -t shell_cash_container:1 . --network host
podman run --net=host -it --env proxy='http://example.com' -e container='podman' --user root --privileged --name shell_clash shell_cash_container:1