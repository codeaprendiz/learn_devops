# docker attach

[https://docs.docker.com/engine/reference/commandline/attach/](https://docs.docker.com/engine/reference/commandline/attach/)

Once you are attached to a container using docker attach
- To stop a container, use CTRL-c. This key sequence sends SIGKILL to the container.
- If the container was run with -i and -t, you can detach from a container and leave it running using the CTRL-p CTRL-q key sequence.
## Attach to and detach from a running container

```bash
❯ docker run -d --name topdemo ubuntu:22.04 /usr/bin/top -b

❯ docker attach topdemo

# pressing CTRL-c terminates the container

❯ docker ps -a
```

- Repeating the example above, but this time with the -i and -t options set;

```bash
❯ docker run -dit --name topdemo2 ubuntu:22.04 /usr/bin/top -b

❯ docker attach topdemo2
# pressing the CTRL-p CTRL-q the attach command is detached from the container
# and the container is still running

❯ docker ps -a 
```


## Get the exit code of the container’s command

- You can see the exit code returned by the bash process is returned by the docker attach command to its caller too

```bash
❯ docker run --name test -dit alpine
❯ docker attach test
/ # exit 13
❯ echo $?
13
❯ docker ps -a --filter name=test
CONTAINER ID   IMAGE     COMMAND     CREATED          STATUS                       PORTS     NAMES
7828441ca97a   alpine    "/bin/sh"   48 seconds ago   Exited (13) 31 seconds ago             test

```

- In the given example, a Docker container is started with the alpine image in detached mode using the docker run command. Then, the docker attach command is used to attach to the running container.
- Inside the container, the exit 13 command is executed, which will cause the bash process to exit with a status code of 13. The docker attach command will then return the same exit code to its caller, which in this case is the shell where the command was executed.
- This means that the exit code returned by the docker attach command will be the same as the exit code returned by the bash process running inside the container. In other words, if the container's main process exits with a non-zero status code, the docker attach command will also return a non-zero status code to indicate that the command failed. This behavior allows you to check the exit status of a command running inside a container, which can be useful for scripting or automation purposes.
