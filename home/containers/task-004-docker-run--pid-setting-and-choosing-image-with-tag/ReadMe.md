## PID Setting and choosing image with Specific Tag

Version Stack

| Stack  | Version  |
|--------|----------|
| Docker | 20.10.14 |


### ImageTag

[imagetag](https://docs.docker.com/engine/reference/run/#imagetag)

- Run image with specific tag say ubuntu:14.04
```bash
❯ docker run --rm -it -d ubuntu:14.04 sh
32bd86340d4773b17d5a9ba5c2f8f448ab4d29186801a6d989ad53a2a0a48af3

❯ docker ps -a                          
CONTAINER ID   IMAGE          COMMAND   CREATED         STATUS         PORTS     NAMES
32bd86340d47   ubuntu:14.04   "sh"      5 seconds ago   Up 4 seconds             practical_ishizaka
```

### PID

[pid-settings---pid](https://docs.docker.com/engine/reference/run/#pid-settings---pid)

Let's create two containers a1 and a2, and we want container a2 to be able to see the processes running in container a1

```bash
# Terminal session 1
❯ docker run --rm --name=a1 -it ubuntu /bin/bash
root@fefc7f52750f:/# sleep 10000



# Terminal session 2
❯ docker ps -a                                  
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
fefc7f52750f   ubuntu    "/bin/bash"   33 seconds ago   Up 32 seconds             a1


# Note that a2 cannot see the processes running inside of a1 yet.
❯ docker run --rm --name=a2 -it ubuntu /bin/bash
root@9630d2dd813f:/# ps -ef 
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 10:34 pts/0    00:00:00 /bin/bash
root         9     1  0 10:34 pts/0    00:00:00 ps -ef
root@9630d2dd813f:/# #let's exit
root@9630d2dd813f:/# exit
exit

❯ docker ps -a                                  
CONTAINER ID   IMAGE     COMMAND       CREATED              STATUS              PORTS     NAMES
fefc7f52750f   ubuntu    "/bin/bash"   About a minute ago   Up About a minute             a1


# Now let's start the second container a2 using pid=container:a1
# Note that now it's able to see the process sleep running in a1
❯ docker run --rm --name=a2 --pid=container:a1 -it ubuntu /bin/bash
root@0bfaed14e83d:/# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 10:33 pts/0    00:00:00 /bin/bash
root        10     1  0 10:33 pts/0    00:00:00 sleep 10000
root        11     0  0 10:35 pts/0    00:00:00 /bin/bash
root        20    11  0 10:35 pts/0    00:00:00 ps -ef

```
