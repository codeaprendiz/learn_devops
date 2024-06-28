## Expose Port, Pull Policy And Environment Variables


Version Stack

| Stack  | Version  |
|--------|----------|
| Docker | 20.10.14 |


### Expose Port

[publish-or-expose-port--p---expose](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose)

```bash
❯ docker run --rm -d -p 8081:80 nginx nginx -g 'daemon off;'            
f73315b8a038d94192802c894c72fa3957ca4db019f312e829c3a612fbf17d63

❯ curl localhost:8081 -I
HTTP/1.1 200 OK
Server: nginx/1.23.2
Date: Mon, 14 Nov 2022 14:59:15 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Wed, 19 Oct 2022 07:56:21 GMT
Connection: keep-alive
ETag: "634fada5-267"
Accept-Ranges: bytes
```

You can visit the same in browser

![nginx.png](.images/nginx.png)

## Pull Policy

[set-the-pull-policy---pull](https://docs.docker.com/engine/reference/commandline/run/#-set-the-pull-policy---pull)

```bash
❯ docker pull ubuntu            
❯ docker images | grep ubuntu             
ubuntu       latest    3c2df5585507   2 weeks ago   69.2MB

❯ docker rmi ubuntu                  


❯ docker run --pull=never ubuntu     
docker: Error response from daemon: No such image: ubuntu:latest.

# As there is no image with this tag locally
❯ docker images | grep ubuntu | wc -l
       0
```


## Environment 

[set-environment-variables--e---env---env-file](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file)

```bash
# Let's create a file
❯ echo "VAR3=value" > .env                                                                              
❯ cat .env              
VAR3=value

❯ docker run --rm -it -e MYVAR1=bar --env MYVAR2=foo --env-file ./.env ubuntu bash
root@9cb685c53176:/# env | grep VAR
MYVAR2=foo
MYVAR1=bar
VAR3=value
root@9cb685c53176:/# exit
exit

❯ docker run --rm -it -e MYVAR1=bar --env MYVAR2=foo --env-file ./.env ubuntu env | grep VAR
VAR3=value
MYVAR1=bar
MYVAR2=foo

```