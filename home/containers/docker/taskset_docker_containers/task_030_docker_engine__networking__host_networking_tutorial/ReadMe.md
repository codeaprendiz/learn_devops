# [Host Networking Tutorial](https://docs.docker.com/engine/network/tutorials/host/)

## Pre-requisites

The host networking driver only works on Linux hosts, but is available as a beta feature on Docker Desktop version 4.29 and later for Mac, Windows, and Linux.

## Procedure

Create and start the container as a detached process on the host network:

```bash
docker run --rm -d --network host --name my_nginx nginx
```

Verify that the container is running:

```bash
$ curl localhost:80 -I
HTTP/1.1 200 OK
Server: nginx/1.27.1
.. truncated output ..
```

Check the processes running on the host:

```bash
lsof -i -P -n | grep LISTEN | egrep :80
```

Output

```bash
COMMAND    PID        USER   FD   TYPE             DEVICE                SIZE/OFF   NODE NAME
com.docke 5857        user  115u  IPv6            xxxxxxxxx              0t0       TCP *:80 (LISTEN)
```
