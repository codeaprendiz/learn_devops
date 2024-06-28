## Assign name and allocate pseudo tty

[assign-name-and-allocate-pseudo-tty---name--it](https://docs.docker.com/engine/reference/commandline/run/#assign-name-and-allocate-pseudo-tty---name--it)

Version Stack

| Stack  | Version  |
|--------|----------|
| Docker | 20.10.14 |


- Let's begin


```bash
# allocate pseudo tty : -it
# --name for container name
❯ docker run --name test -it debian

root@d6c0fe130dba:/# exit 13

# Note the exit code is passed to the caller of docker run.
❯ echo $?                                                                                               
13
❯ docker ps -a                                                          
CONTAINER ID   IMAGE     COMMAND   CREATED              STATUS                       PORTS     NAMES
4a94928d6520   debian    "bash"    About a minute ago   Exited (13) 54 seconds ago             test
```

## Capture container ID

[capture-container-id---cidfile](https://docs.docker.com/engine/reference/commandline/run/#capture-container-id---cidfile)

- This will create a container and print `test` to the console. The `cidfile` flag makes Docker attempt to create a new file and write the container ID to it.

```bash
❯ docker run --cidfile /tmp/docker_test.cid ubuntu echo "test"
test

❯ docker ps -a                                                          
CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS                     PORTS     NAMES
c2683f80d7bf   ubuntu    "echo test"   5 seconds ago   Exited (0) 4 seconds ago             youthful_hypatia

# Note the container ID got captured in the file
❯ cat /tmp/docker_test.cid              
c2683f80d7bf613f4004911904a908377a43fb1ab556988f3aa9992647cd184a


```

