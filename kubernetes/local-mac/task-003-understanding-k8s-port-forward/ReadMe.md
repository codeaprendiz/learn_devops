- Create nginx deployment

```bash
$ kubectl create deployment nginx-dep --image=nginx --replicas=2
```

- Get the pods

```bash
$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
nginx-dep-5c5477cb4-76t9q   1/1     Running   0          7h5m
nginx-dep-5c5477cb4-9g84j   1/1     Running   0          7h5m
```

- Access the pod using `kubectl port`

```bash
$ kubectl port-forward nginx-dep-5c5477cb4-9g84j 8888:80
Forwarding from 127.0.0.1:8888 -> 80
Forwarding from [::1]:8888 -> 80
```

- Now do a `curl` to the `localhost:8888`

```bash
$ curl -v http://localhost:8888             
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8888 (#0)
> GET / HTTP/1.1
> Host: localhost:8888
> User-Agent: curl/7.64.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.21.0
< Date: Sat, 03 Jul 2021 11:10:23 GMT
< Content-Type: text/html
< Content-Length: 612
< Last-Modified: Tue, 25 May 2021 12:28:56 GMT
< Connection: keep-alive
< ETag: "60aced88-264"
< Accept-Ranges: bytes
< 
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
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
* Connection #0 to host localhost left intact
* Closing connection 0
```

- In the output you will also see

```bash
$ kubectl port-forward nginx-dep-5c5477cb4-9g84j 8888:80
Forwarding from 127.0.0.1:8888 -> 80
Forwarding from [::1]:8888 -> 80
Handling connection for 8888
```