### To test custom TLS certs with docker-caddy

#### Directory structure

```bash
local-mac/task-012-caddy-https-domain-test-with-custom-certs
├── Caddyfile
├── ReadMe.md
├── certs
│   ├── star_domain.com.key
│   └── star_domain_com.chained.crt
├── docker-compose.yml
├── index.html
└── password-generation.yml
```

- docker-compose.yaml

```yaml
version: "3.7"

services:
  caddy:
    image: caddy:latest
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - $PWD/index.html:/usr/share/caddy/index.html
      - $PWD/Caddyfile:/etc/caddy/Caddyfile
      - $PWD/caddy_data:/data
      - ./certs:/etc/ssl/certs
    networks:
      - host

volumes:
  data01:
    driver: local

networks:
  host:
```

- Caddyfile

```bash
cert-validation-srv.domain.com:443 {
    tls /etc/ssl/certs/star_domain_com.chained.crt /etc/ssl/certs/star_domain.com.key
    root * /usr/share/caddy
    file_server
    basicauth * {
            username JDJiJDEyJGIuMEhnMU9IRkhCLlB4cUZPMVpJcWU0azVvdDcxQUdISHFOdE40eDVkdThRODlqRDFJRHJX
    }
}
```

- index.html

```bash
hello world
```

- password-generation.yml

```yaml
- hosts: localhost
  gather_facts: false
  tasks:
    - debug:
        msg: "Password to be encrypted - {{ 'password_admin' | password_hash('bcrypt') | b64encode }}"
```

- Suppose we have the certs for custom domain `*.domain.com` and the certs are saved at the location `certs`

```bash
$ ls certs          
star_domain.com.key         star_domain_com.chained.crt 
```

- Ensure that we have the following entry is added to `/etc/hosts` file. As we will test the TLS certs for this domain.

```bash
$ cat /etc/hosts | grep cert-validation
127.0.0.1 cert-validation-srv.domain.com
``` 

- Start the docker caddy

```bash
docker-compose up
```

- Since there is automatic redirect from http to https we will see the following observations

```bash
$ curl  http://cert-validation-srv.domain.com 

$ curl -L http://cert-validation-srv.domain.com
hello world

$ curl https://cert-validation-srv.domain.com
hello world
```

- You can generate the password using the playbook. You have to put this password in Caddy file.  [Reference](https://caddyserver.com/docs/caddyfile/directives/basicauth)

```bash
$ ansible-playbook password-generation.yml -v
ok: [localhost] => {
    "msg": "JDJiJDEyJGRrWnExWmJGbnp0b3BoZmVjSVRnNk9TZXZ3T3VLNTFHUS9nRGs4a00yZ0lZQTZrSUR6MDUy"
}
```

