
### To set the upper limit on memory to 512 megabytes used by nginx container
```bash
$ docker run -m 512m nginx

$ docker ps | egrep -v "k8s"     
CONTAINER ID   IMAGE                  COMMAND                  CREATED              STATUS              PORTS                  NAMES
6959c8b602ba   nginx                  "/docker-entrypoint.…"   About a minute ago   Up About a minute   80/tcp                 intelligent_bartik

$ docker stats intelligent_bartik
CONTAINER ID   NAME                 CPU %     MEM USAGE / LIMIT   MEM %     NET I/O       BLOCK I/O         PIDS
6959c8b602ba   intelligent_bartik   0.00%     4.316MiB / 512MiB   0.84%     1.17kB / 0B   7.42MB / 8.19kB   2
```

### To set the upper limit on the number of CPUs used by nginx container

By default, access to the computing power of the host machine is unlimited. We can set the CPUs limit using the cpus parameter. For example, let's constrain our container to use at most two CPUs:


```bash
$ docker run --cpus=2 nginx
```