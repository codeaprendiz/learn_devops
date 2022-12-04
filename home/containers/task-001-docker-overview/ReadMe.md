# Docker overview


[docs.docker.com/get-started/overview](https://docs.docker.com/get-started/overview)

Version Stack

| Stack  | Version  |
|--------|----------|
| Docker | 20.10.14 |


## Usecase to solve actual problem

### docker run

The following command runs an `ubuntu` container, attaches interactively to your local command-line session, and runs `/bin/bash`.



```bash
# Version
❯ docker -v               
Docker version 20.10.14, build a224086

# run : Run a command in a new container
# -i : interactively
# -t : attached to your terminal
# ubuntu : is the image we will be downloading
# /bin/bash : the command that will run inside the container started with ubuntu image
❯  docker run -i -t ubuntu /bin/bash

root@f3d2356faadc:/# ls
bin  boot  dev  etc  home  lib  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

# exit


❯ docker ps          # To show all running containers     
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

❯ docker ps -a       # To show all containers including stopped ones
CONTAINER ID   IMAGE     COMMAND   CREATED          STATUS                      PORTS     NAMES
864a03e87269   ubuntu    "sh"      23 seconds ago   Exited (0) 17 seconds ago             unruffled_margulis

❯ docker rm  unruffled_margulis    # Remove the container           
unruffled_margulis

❯ docker ps -a                 
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

❯ 
```

Docker starts the container and executes /bin/bash. Because the container is running interactively and attached to your terminal (due to the -i and -t flags), you can provide input using your keyboard while the output is logged to your terminal.

That's all for today!