# docker build

[docs.docker.com/engine/reference/commandline/build](https://docs.docker.com/engine/reference/commandline/build/)

**High Level Objectives**
- run nginx docker on port 8080
- create a custom dockerfile with some changes
- build an image with specific tag
- run container that uses new image
- understand the differences

**Skills**
- docker
- docker build
- tag
- docker images

**Version Stack**

| Stack  | Version   |
|--------|-----------|
| docker | 20.10.14  |

## run nginx container

```bash
❯ docker run -it --rm -d -p 8080:80 --name nginx nginx
a6d8a4f9987c77a27c4f7864b82d86a1a1c0a899bf79bd3b70ef893ae74cf92d

❯ docker ps -a                                        
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                  NAMES
a6d8a4f9987c   nginx     "/docker-entrypoint.…"   4 seconds ago   Up 4 seconds   0.0.0.0:8080->80/tcp   nginx

❯ curl localhost:8080                      
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>


❯ docker exec -it nginx bash
root@41e0b0f9b11b:/# ls /usr/share/nginx/html/
50x.html  index.html
root@41e0b0f9b11b:/# cat /usr/share/nginx/html/index.html 
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

## Create Dockerfile and index.html

## Build

```bash
❯ docker build -f Dockerfile .


```

## Check images


```bash
❯ docker images | head -n 2   
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
<none>       <none>    9a69d38ae721   32 seconds ago   135MB


```

## Tag 

```bash
❯ docker build -t my-docker-image -f Dockerfile .

❯ docker images | head -n 2                      
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
my-docker-image   latest    9a69d38ae721   About a minute ago   135MB
```

## Run image with new container

```bash
❯ docker ps -a | grep -v "IMAGE" |  awk '{ print $NF}' | xargs docker stop
nginx

❯ docker run -it --rm -d -p 8080:80 --name nginx my-docker-image:latest   
1535f427e222e04b71d91c7b4ccb740ec2d1fb4624828bb4f145e303fc1815c3


❯ curl localhost:8080
<html>
<head>
    <title>Hello, Docker!</title>
</head>
<body>
<h1>Hello, Docker!</h1>
<p>Welcome to my Docker container!</p>
</body>
</html>



❯ docker exec -it nginx bash                                           
root@7e144aa1d8ec:/# cat /usr/share/nginx/html/index.html 
<html>
<head>
    <title>Hello, Docker!</title>
</head>
<body>
<h1>Hello, Docker!</h1>
<p>Welcome to my Docker container!</p>
</body>
</html>
root@7e144aa1d8ec:/# 

```