
[nginx docker container](https://www.digitalocean.com/community/tutorials/how-to-run-nginx-in-a-docker-container-on-ubuntu-14-04)

- Start the container

```bash
docker run --rm                            \
--name docker-nginx                   \
-p 8080:80                              \
-d                                    \
--volume $PWD/html:/usr/share/nginx/html    \
--volume $PWD/conf.d:/etc/nginx/conf.d      \
nginx
```

- Check

```bash
$ docker ps -a | egrep -v "k8s"                                                                                                           
CONTAINER ID   IMAGE                                  COMMAND                  CREATED         STATUS         PORTS                                   NAMES
33680e0cb240   nginx                                  "/docker-entrypoint.…"   5 seconds ago   Up 3 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   docker-nginx
```

- Test the endpoint

```bash
$ curl localhost:8080
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-MfvZlkHCEqatNoGiOXveE8FIwMzZg4W85qfrfIFBfYc= sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <title>Docker nginx Tutorial</title>
</head>
<body>
<div class="container">
    <h1>Hello Digital Ocean</h1>
    <p>This nginx page is brought to you by Docker and Digital Ocean</p>
</div>
</body>
</html>
```

- Check if your file is mounted

```bash
$ docker exec -it docker-nginx sh
# ls /usr/share/nginx/html
index.html
# cat /usr/share/nginx/html/index.html
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-MfvZlkHCEqatNoGiOXveE8FIwMzZg4W85qfrfIFBfYc= sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <title>Docker nginx Tutorial</title>
</head>
<body>
<div class="container">
    <h1>Hello Digital Ocean</h1>
    <p>This nginx page is brought to you by Docker and Digital Ocean</p>
</div>
</body>
</html># 


# ls /etc/nginx/conf.d
default.conf
```

- Test wrong endpoint

```bash
$ curl localhost:8080/give404
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx/1.21.0</center>
</body>
</html>
```