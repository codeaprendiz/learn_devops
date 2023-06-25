### To test the certificates are working

- nslookup to domain

```bash
$ nslookup server.domain.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   server.domain.com
Address: 23.12.43.56
```

- The following is the `docker-compose` file

```yaml
version: "3.7"
services:
  nginx:
    image: nginx:latest
    ports:
      - 80:80
      - 443:443
    volumes:
      - ./certs:/etc/nginx/certs
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
```

- The following is `nginx.conf` file

```bash
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

- Dir structure

```yaml
$ tree ../gcp/task-011-nginx-https-domain-test 
../gcp/task-011-nginx-https-domain-test
├── ReadMe.md
├── certs
│   ├── star_domain.com.key
│   └── star_domain_com.chained.crt
├── docker-compose.yml
└── nginx.conf

```

- Login to the server  23.12.43.56. Assuming the certificates and key are valid for `*.domain.com`

```bash
$ docker-compose up -d
```



- Visit `https://server.domain.com/` on browser and validate if its being loaded
