

To test the certificates are working

- nslookup to domain
```bash
$ nslookup server.domain.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   server.domain.com
Address: 23.12.43.56
```

- Login to the server  23.12.43.56. Assuming the certificates and key are valid for `*.domain.com`

```bash
$ ls -ltrh
total 20K
-rwxrwxrwx 1 server server 3.2K Aug 20 16:10 star_domain.com.key
-rwxrwxrwx 1 server server 8.5K Aug 20 16:10 star_domain_com.chained.crt
-rwxrwxrwx 1 server server  335 Aug 20 16:45 nginx.conf
```

- Contents of nginx.conf
```bash
$ cat nginx.conf                
server {
    listen 443 ssl;
    server_name  prod.domain.com;
    ssl_certificate /etc/nginx/certs/star_domain_com.chained.crt;
    ssl_certificate_key /etc/nginx/certs/star_domain.com.key;
    location / {
        allow all;
        root /usr/share/nginx/html;
    }

    root /usr/share/nginx/html;
    index index.html;
}
```


- Start the docker container
```bash
$ docker run --rm -p 80:80 -p 443:443  \
--name nginx_service \
-v $PWD/star_domain.com.key:/etc/nginx/certs/star_domain.com.key \
-v $PWD/star_domain_com.chained.crt:/etc/nginx/certs/star_domain_com.chained.crt \
-v $PWD/nginx.conf:/etc/nginx/conf.d/default.conf \
  nginx:latest
```

- Visit `https://server.domain.com/` on browser and validate if its being loaded
