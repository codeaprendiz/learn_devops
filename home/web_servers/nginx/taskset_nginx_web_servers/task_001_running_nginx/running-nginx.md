### Running nginx using docker and access on port 80 of host

```bash
$ docker run -it --rm -d -p 8080:80 --name web nginx
```

Accessing on [http://localhost:8080](http://localhost:8080)

```bash
$ curl localhost:8080 -I
HTTP/1.1 200 OK
Server: nginx/1.25.1
Date: Mon, 26 Jun 2023 07:08:43 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 13 Jun 2023 15:08:10 GMT
Connection: keep-alive
ETag: "6488865a-267"
Accept-Ranges: bytes

```