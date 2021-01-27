### Ngnix docker-compose hello world



#### Directory structure

```bash
nginx/task-002-nginx-docker-compose-hello-world
├── docker-compose.yaml
├── nginx-docker-compose-hello-world.md
└── src
    └── index.html
```

- docker-compose.yml

```yaml
version: "3"

services:
  client:
    image: nginx
    ports:
      - 8000:80
    volumes:
      - ./src:/usr/share/nginx/html
```

- src/index.html

```html
hello from src/index.html
```

- Start the server using
```bash
$ docker-compose up
```


- Now hit the localhost using curl
```bash
$ curl http://localhost:8000                 
hello from src/index.html
```

- You will get the same response from browser as well