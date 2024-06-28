## We will try to get ACME certs for test.domain.com and docker-caddy server. 


### Directory structure

```bash
$ tree local-mac/task-013-caddy-https-acme-and-save-certs          
local-mac/task-013-caddy-https-acme-and-save-certs
├── Caddyfile
├── ReadMe.md
└── docker-compose.yml
```

- docker-compose.yaml

```bash
version: "3.7"

services:
  caddy:
    image: caddy:2.2.1
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - $PWD/Caddyfile:/etc/caddy/Caddyfile
      - $PWD/data:/data/caddy
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
test.domain.com:443 {
    root * /usr/share/caddy
    file_server
}
```

- Ensure that you are logged into the server test.domain.com (33.455.23.67)

```bash
$ nslookup test.domain.com
Server:         34.42.23.20
Address:        34.42.34.20#53

Non-authoritative answer:
Name:   test.domain.com
Address: 33.455.23.67
```



- Ensure that the following `data` are present. Here we will store the certificates on the host so that on restarting it caddy server does not do the 
ACME challenge again. 

```bash
mkdir data
```


- Run the docker-compose file. (When the data director is not mounted | When the data directory is mounted and we are running for the first time)

```bash
$ docker-compose up
Creating network "root_default" with the default driver
Pulling caddy (caddy:2.2.1)...
2.2.1: Pulling from library/caddy
801bfaa63ef2: Pull complete
1afadb5ee6ea: Pull complete
47e5593f16cf: Pull complete
093aa05efcd0: Pull complete
06e6e211c46d: Pull complete
Digest: sha256:9ce208090b30673d941f890c84b172b5cacbc2ec65099ec778c8ee5b07e809ff
Status: Downloaded newer image for caddy:2.2.1
Creating root_caddy_1 ... done
Attaching to root_caddy_1
caddy_1  | {"level":"info","ts":1609757632.0677993,"msg":"using provided configuration","config_file":"/etc/caddy/Caddyfile","config_adapter":"caddyfile"}
caddy_1  | {"level":"info","ts":1609757632.0694492,"logger":"admin","msg":"admin endpoint started","address":"tcp/localhost:2019","enforce_origin":false,"origins":["localhost:2019","[::1]:2019","127.0.0.1:2019"]}
caddy_1  | {"level":"info","ts":1609757632.0710332,"logger":"http","msg":"server is listening only on the HTTPS port but has no TLS connection policies; adding one to enable TLS","server_name":"srv0","https_port":443}
caddy_1  | {"level":"info","ts":1609757632.07108,"logger":"http","msg":"enabling automatic HTTP->HTTPS redirects","server_name":"srv0"}
caddy_1  | {"level":"info","ts":1609757632.071871,"logger":"tls.cache.maintenance","msg":"started background certificate maintenance","cache":"0xc000338770"}
caddy_1  | {"level":"info","ts":1609757632.072646,"logger":"tls","msg":"cleaned up storage units"}
caddy_1  | {"level":"info","ts":1609757632.0730252,"logger":"http","msg":"enabling automatic TLS certificate management","domains":["test.domain.com"]}
caddy_1  | {"level":"info","ts":1609757632.0741072,"logger":"tls.obtain","msg":"acquiring lock","identifier":"test.domain.com"}
caddy_1  | {"level":"info","ts":1609757632.074884,"logger":"tls.obtain","msg":"lock acquired","identifier":"test.domain.com"}
caddy_1  | {"level":"info","ts":1609757632.0852695,"msg":"autosaved config","file":"/config/caddy/autosave.json"}
caddy_1  | {"level":"info","ts":1609757632.0852895,"msg":"serving initial configuration"}
caddy_1  | {"level":"info","ts":1609757633.2071838,"logger":"tls.issuance.acme","msg":"waiting on internal rate limiter","identifiers":["test.domain.com"]}
caddy_1  | {"level":"info","ts":1609757633.207216,"logger":"tls.issuance.acme","msg":"done waiting on internal rate limiter","identifiers":["test.domain.com"]}
caddy_1  | {"level":"info","ts":1609757633.7696266,"logger":"tls.issuance.acme.acme_client","msg":"trying to solve challenge","identifier":"test.domain.com","challenge_type":"tls-alpn-01","ca":"https://acme-v02.api.letsencrypt.org/directory"}
caddy_1  | {"level":"info","ts":1609757634.0587502,"logger":"tls","msg":"served key authentication certificate","server_name":"test.domain.com","challenge":"tls-alpn-01","remote":"18.196.96.172:28288"}
caddy_1  | {"level":"info","ts":1609757634.0822861,"logger":"tls","msg":"served key authentication certificate","server_name":"test.domain.com","challenge":"tls-alpn-01","remote":"3.128.26.105:48376"}
caddy_1  | {"level":"info","ts":1609757634.1294994,"logger":"tls","msg":"served key authentication certificate","server_name":"test.domain.com","challenge":"tls-alpn-01","remote":"66.133.109.36:44218"}
caddy_1  | {"level":"info","ts":1609757634.1341765,"logger":"tls","msg":"served key authentication certificate","server_name":"test.domain.com","challenge":"tls-alpn-01","remote":"34.209.232.166:29258"}
caddy_1  | {"level":"info","ts":1609757634.318466,"logger":"tls.issuance.acme.acme_client","msg":"validations succeeded; finalizing order","order":"https://acme-v02.api.letsencrypt.org/acme/order/108315222/7118077632"}
caddy_1  | {"level":"info","ts":1609757634.9939814,"logger":"tls.issuance.acme.acme_client","msg":"successfully downloaded available certificate chains","count":2,"first_url":"https://acme-v02.api.letsencrypt.org/acme/cert/0301a56075e122ef701964489e83f46d52d2"}
caddy_1  | {"level":"info","ts":1609757634.9943607,"logger":"tls.obtain","msg":"certificate obtained successfully","identifier":"test.domain.com"}
caddy_1  | {"level":"info","ts":1609757634.994378,"logger":"tls.obtain","msg":"releasing lock","identifier":"test.domain.com"}
```

- After saving the certificates we will get the following logs. When the data directory is mounted and we are running for second/third... time

```bash
$ docker-compose up
Creating network "root_host" with the default driver
Creating root_caddy_1 ... done
Attaching to root_caddy_1
caddy_1  | {"level":"info","ts":1609768981.0444334,"msg":"using provided configuration","config_file":"/etc/caddy/Caddyfile","config_adapter":"caddyfile"}
caddy_1  | {"level":"info","ts":1609768981.0476024,"logger":"admin","msg":"admin endpoint started","address":"tcp/localhost:2019","enforce_origin":false,"origins":["[::1]:2019","127.0.0.1:2019","localhost:2019"]}
caddy_1  | {"level":"info","ts":1609768981.0484183,"logger":"http","msg":"server is listening only on the HTTPS port but has no TLS connection policies; adding one to enable TLS","server_name":"srv0","https_port":443}
caddy_1  | {"level":"info","ts":1609768981.0484402,"logger":"http","msg":"enabling automatic HTTP->HTTPS redirects","server_name":"srv0"}
caddy_1  | {"level":"info","ts":1609768981.048677,"logger":"tls.cache.maintenance","msg":"started background certificate maintenance","cache":"0xc0002d8460"}
caddy_1  | {"level":"info","ts":1609768981.050361,"logger":"tls","msg":"cleaned up storage units"}
caddy_1  | {"level":"info","ts":1609768981.0505176,"logger":"http","msg":"enabling automatic TLS certificate management","domains":["test.domain.com"]}
caddy_1  | {"level":"info","ts":1609768981.060168,"msg":"autosaved config","file":"/config/caddy/autosave.json"}
caddy_1  | {"level":"info","ts":1609768981.060194,"msg":"serving initial configuration"}
```

- TIP: to find the location of the certificates inside the docker-caddy container, login to the container and run the following command

```bash]
/ # pwd
/
/ # find . -name "*.crt" | grep -v "/usr/share"
./etc/ssl/certs/ca-certificates.crt
./data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/test.domain.com/test.domain.com.crt
```

- Once the certificates are generated you will see the following in the data directory

```bash
$ ls data/certificates/acme-v02.api.letsencrypt.org-directory/test.domain.com
test.domain.com.crt  test.domain.com.json  test.domain.com.key
```
