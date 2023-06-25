[Persist Data](https://docs.docker.com/get-started/05_persisting_data/)


- Start an ubuntu container that will create a file named /data.txt with a random number between 1 and 10000.

```bash
$ docker run -d ubuntu bash -c "shuf -i 1-10000 -n 1 -o /data.txt && tail -f /dev/null"
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
405f018f9d1d: Pull complete 
Digest: sha256:b6b83d3c331794420340093eb706a6f152d9c1fa51b262d9bf34594887c2c7ac
Status: Downloaded newer image for ubuntu:latest
e50a2711cff9a7297fe7fa056f3bd63ea80ca2ea84d12e74a8c7724d31ab5e22
```

- Let's exec into the container to check

```bash
$ docker ps            
CONTAINER ID   IMAGE                  COMMAND                  CREATED              STATUS              PORTS     NAMES
e50a2711cff9   ubuntu                 "bash -c 'shuf -i 1-…"   About a minute ago   Up About a minute             gracious_hofstadter

$ docker exec -it e50a2711cff9 sh     
# cat /data.txt
8364
```

- Now, let’s start another ubuntu container (the same image) and we’ll see we don’t have the same file.

```bash
$ docker run -it ubuntu ls /
bin   dev  home  lib32  libx32  mnt  proc  run   srv  tmp  var
boot  etc  lib   lib64  media   opt  root  sbin  sys  usr
```

- And look! There’s no data.txt file there! That’s because it was written to the scratch space for only the first container.

```bash
$ docker rm -f e50a2711cff9
e50a2711cff9
```


- Now we will try to persist the data. Create a volume by using the docker volume create command.

```bash
 docker volume create todo-db
todo-db
```

- Stop any existing containers if its already running

```bash
$ docker run -dp 3000:3000 -v todo-db:/etc/todos getting-started
aebdfdb8fdc54fbbfd30b3850718745d0a3e0df0b5f79f496f2ce1365a9a3cac
```

- Add some items 

![](.images/2022-07-25-17-23-50.png)

- Now let's remove the container completely

```bash
$ docker rm -f aebdfdb8fdc5
aebdfdb8fdc5
```


- Start a new container again using the same command

```bash
$ docker run -dp 3000:3000 -v todo-db:/etc/todos getting-started
5acf95e35e0dc8d3b50fda6faf6d7618c66948103f7e423e1be033951f338059
```

- You will find that the items are still there

- Let's inspect the docker volume to know more about where its actually storing it.

```bash
$ docker volume inspect todo-db
[
    {
        "CreatedAt": "2022-07-25T13:21:53Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/todo-db/_data",
        "Name": "todo-db",
        "Options": {},
        "Scope": "local"
    }
]
```