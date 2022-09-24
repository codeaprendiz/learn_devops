## Create required docker image of nginx and test k8s pod locally

[nginx docker container](https://www.digitalocean.com/community/tutorials/how-to-run-nginx-in-a-docker-container-on-ubuntu-14-04)

- Start the container

```bash
$ docker run --rm --name docker-nginx -p 8080:80 -d --volume $PWD/html:/usr/share/nginx/html --volume $PWD/conf.d:/etc/nginx/conf.d nginx
```

- Check 200

```bash
$ curl localhost:8080/check.txt -I
HTTP/1.1 200 OK
Server: nginx/1.21.0
Date: Tue, 24 Aug 2021 19:29:12 GMT
Content-Type: text/plain
Content-Length: 13
Connection: keep-alive

$ curl localhost:8080/check.txt  
Its working!!
```

- Check 403

```bash
$ curl localhost:8080/403      
Forbidden!

$ curl localhost:8080/403 -I
HTTP/1.1 403 Forbidden
Server: nginx/1.21.0
Date: Tue, 24 Aug 2021 19:29:55 GMT
Content-Type: application/octet-stream
Content-Length: 10
Connection: keep-alive                                                                                                                                                                                                           
```

- Now if you create a docker image

```bash
$ docker build --file Dockerfile -t codeaprendiz/nginx .                                                                   
```

- And start the container using the same image

```bash
$ docker run --rm --name docker-nginx -p 8080:80 -d  codeaprendiz/nginx                                                                  
$ curl localhost:8080/403 -I
HTTP/1.1 403 Forbidden
Server: nginx/1.21.1
Date: Tue, 24 Aug 2021 19:38:22 GMT
Content-Type: application/octet-stream
Content-Length: 10
Connection: keep-alive

$ curl localhost:8080/403   
Forbidden!

$ curl localhost:8080/500
Application Error!
```

- Push the docker image

```bash
$ docker push codeaprendiz/nginx
```

- Create nginx container in kubernetes

```bash
$ kubectl run nginx-pod --image=codeaprendiz/nginx:latest 

## PORT FORWARD and test yoour changes
$ kubectl port-forward pod/nginx-pod 8080:80 


## in another terminal
$ curl localhost:8080/check.txt
Its working!!
$ curl localhost:8080/403/ 
Forbidden!
```