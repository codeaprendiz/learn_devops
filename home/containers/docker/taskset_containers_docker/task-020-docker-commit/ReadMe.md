# docker commit

It can be useful to commit a container’s file changes or settings into a new image. 
This allows you to debug a container by running an interactive shell, or to export a working dataset to another server

[docs.docker.com/engine/reference/commandline/commit](https://docs.docker.com/engine/reference/commandline/commit)

**High Level Objectives**
- start ubuntu container with bash. Make some changes
- commit the container state to image
- start new container with our new image, validate our changes
- add env using --change and repeat validation process

**Skills**
- docker
- docker commit
- commit
- docker images
- docker inspect
- docker commit --change


**Version Stack**

| Stack  | Version   |
|--------|-----------|
| docker | 20.10.14  |


# run ubuntu container

```bash
# Terminal session t1
❯ docker run -it --rm --name ubuntu ubuntu bash
root@4d74a15a73eb:/# cd /home
root@4d74a15a73eb:/home# ls
root@4d74a15a73eb:/home# echo "I am new file" > file.txt
root@4d74a15a73eb:/home# ls
file.txt
root@4d74a15a73eb:/home#


## New Terminal session t2
❯ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED          STATUS          PORTS     NAMES
4d74a15a73eb   ubuntu    "bash"    45 seconds ago   Up 44 seconds             ubuntu

❯ docker commit 4d74a15a73eb my-ubuntu:v1                             
sha256:9fec4fd33de4966790bb4b2920abeefc4d33513c8c2bbb3641d6609caab2086f

❯ docker images | head -n 2              
REPOSITORY        TAG       IMAGE ID       CREATED             SIZE
my-ubuntu         v1        9fec4fd33de4   12 seconds ago      69.2MB


## terminal session t1
root@4d74a15a73eb:/home#
root@4d74a15a73eb:/home# exit
exit

❯ docker ps -a                                 
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

❯ docker run -it --rm --name ubuntu my-ubuntu:v1 bash
root@8d61e1d9a312:/# cd /home
root@8d61e1d9a312:/home# ls
file.txt




# terminal session t2
❯ docker ps -a             
CONTAINER ID   IMAGE          COMMAND   CREATED         STATUS         PORTS     NAMES
8d61e1d9a312   my-ubuntu:v1   "bash"    6 minutes ago   Up 6 minutes             ubuntu

❯ docker inspect -f "{{ .Config.Env }}" 8d61e1d9a312
[PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin]

❯ docker commit --change "ENV DEBUG=true" 8d61e1d9a312 my-ubuntu:v2
sha256:e7eb352de7b38ae12046552925d2ff9ef61d1dc14894a709dd28c499dda50243

❯ docker images | head -n 2                                        
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
my-ubuntu         v2        e7eb352de7b3   About a minute ago   214MB




# Terminal session t1
root@4d74a15a73eb:/home#
root@8d61e1d9a312:/home# exit
exit

❯ docker ps -a                                       
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

❯ docker run -it --rm --name ubuntu my-ubuntu:v2 bash
root@072729702c8b:/# env | grep DEBUG
DEBUG=true


# Terminal session t2
❯ docker ps -a             
CONTAINER ID   IMAGE          COMMAND   CREATED         STATUS         PORTS     NAMES
072729702c8b   my-ubuntu:v2   "bash"    2 minutes ago   Up 2 minutes             ubuntu

❯ docker inspect -f "{{ .Config.Env }}" 072729702c8b            
[PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin DEBUG=true]
```