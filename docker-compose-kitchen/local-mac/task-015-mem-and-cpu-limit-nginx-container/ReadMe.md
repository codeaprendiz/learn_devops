
### To set memory and cpu limit in version 3 of docker-compose

[issue-on-linux](https://stackoverflow.com/questions/42345235/how-to-specify-memory-cpu-limit-in-docker-compose-version-3)

Let's give the Nginx service limit of half of CPU and 512 megabytes of memory, and reservation of a quarter of CPU and 128 megabytes of memory. We need to create “deploy” and then “resources” segments in our service configuration:

```yaml
version: "3.8"
services:
  service:
    image: nginx
    deploy:
        resources:
            limits:
              cpus: 0.50
              memory: 512M
            reservations:
              cpus: 0.25
              memory: 128M
```

- This actually works on mac-os
```bash
$ docker-compose -f docker-compose-v3.8.yaml up -d
$ docker stats task-015-mem-and-cpu-limit-nginx-container_service_1
CONTAINER ID   NAME                                                   CPU %     MEM USAGE / LIMIT   MEM %     NET I/O       BLOCK I/O     PIDS
69bacb168f51   task-015-mem-and-cpu-limit-nginx-container_service_1   0.00%     2.133MiB / 512MiB   0.42%     1.17kB / 0B   0B / 8.19kB   2
```


### To set memory and cpu limit in version 2 of docker-compose

```yaml
version: "2.4"
services:
  nginx-service:
    image: nginx
    mem_limit: 512m
    mem_reservation: 128M
    cpus: 0.5
    ports:
      - "80:80"

```

```bash
$ docker-compose -f docker-compose-v2.4.yaml up -d   
Creating network "task-015-mem-and-cpu-limit-nginx-container_default" with the default driver
Creating task-015-mem-and-cpu-limit-nginx-container_nginx-service_1 ... done

$ docker ps | egrep -v "k8s"                                                 
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS          PORTS                  NAMES
9e83cefc711e   nginx                  "/docker-entrypoint.…"   36 seconds ago   Up 35 seconds   0.0.0.0:80->80/tcp     task-015-mem-and-cpu-limit-nginx-container_nginx-service_1

$ docker stats task-015-mem-and-cpu-limit-nginx-container_nginx-service_1                                                   
CONTAINER ID   NAME                                                         CPU %     MEM USAGE / LIMIT   MEM %     NET I/O       BLOCK I/O     PIDS
9e83cefc711e   task-015-mem-and-cpu-limit-nginx-container_nginx-service_1   0.00%     2.102MiB / 512MiB   0.41%     1.24kB / 0B   0B / 8.19kB   2
```