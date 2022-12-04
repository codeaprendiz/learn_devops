## Restart Policy, edit hosts file and set memory limits

### Restart Policy

[restart-policies---restart](https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart)

```bash
# Terminal Session 1
❯ docker run -it --restart=always redis sh                              
# 


# Terminal Session 2
❯ docker ps -a                                                          
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS      NAMES
e536a9ad13e7   redis     "docker-entrypoint.s…"   5 seconds ago   Up 5 seconds   6379/tcp   zealous_jones

# Terminal session 1
# exit 23
❯ 

# Terminal Session 2
❯ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS         PORTS      NAMES
e536a9ad13e7   redis     "docker-entrypoint.s…"   15 seconds ago   Up 2 seconds   6379/tcp   zealous_jones

# As you can see the container came back up 2 seconds ago
```

### Edit hosts file

[add-entries-to-container-hosts-file---add-host](https://docs.docker.com/engine/reference/commandline/run/#add-entries-to-container-hosts-file---add-host)

```bash
❯ docker run --add-host=docker:93.184.216.34 --rm -it alpine
/ # ping docker
PING docker (93.184.216.34): 56 data bytes
64 bytes from 93.184.216.34: seq=0 ttl=37 time=206.845 ms
.
.
/ # cat /etc/hosts | grep docker
93.184.216.34   docker
```

### Memory Limit

[specify-hard-limits-on-memory-available-to-containers--m---memory](https://docs.docker.com/engine/reference/commandline/run/#specify-hard-limits-on-memory-available-to-containers--m---memory)

```bash
❯ docker run --rm -it --memory="1g" ubuntu                              
root@a2d0cf9562af:/# cat /sys/fs/cgroup/memory.max
1073741824
root@a2d0cf9562af:/# exit
exit

❯ docker run --rm -it --memory="2g" ubuntu
root@1195935b38e0:/# cat /sys/fs/cgroup/memory.max
2147483648
root@1195935b38e0:/# 
```