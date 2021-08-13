### Running nginx using docker and access on port 80 of host

```bash
$ docker run -it --rm -d -p 8080:80 --name web nginx
```

Accessing on [http://localhost/](http://localhost/)

![](../../images/nginx/nginx-home.png)