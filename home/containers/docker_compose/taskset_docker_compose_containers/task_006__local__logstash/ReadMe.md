## Logstash docker-compose

- input from file
- filter logs using grok filter (allowed everything)
- output to stdout

### Director structure

```bash
$ tree local-mac/task-006-logstash                                            
local-mac/task-006-logstash
├── ReadMe.md
├── conf
│   └── filter.conf
├── docker-compose.yml
├── log-sample
│   └── access.log
└── logstash.yml
```

- docker-compose.yaml

```yaml
version: '3.7'
services:
  logstash-sandbox:
    image: docker.elastic.co/logstash/logstash:7.8.0
    container_name: logstash-sandbox
    user: root
    volumes:
      - ./logstash.yml:/usr/share/logstash/config/logstash.yml
      - ./conf:/var/logstash/configuration
      - ./log-sample:/tmp
    ports:
      - 9600:9600
      - 5044:5044
    networks:
      - host
networks:
  host:
```

- logstash.yml

```yaml
http.host: 0.0.0.0
xpack.monitoring.enabled: false
xpack.management.enabled: false

config.reload.automatic: true
config.reload.interval: 6s

log.level: info
log.format: json

path.config: /var/logstash/configuration/*.conf
```


- access.log

```log
127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] "GET /xampp/status.php HTTP/1.1" 200 3891 "http://cadenza/xampp/navi.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0"
127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] "GET /xampp/status.php HTTP/1.1" 200 3891 "http://cadenza/xampp/navi.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0"
127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] "GET /xampp/status.php HTTP/1.1" 200 3891 "http://cadenza/xampp/navi.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0"
127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] "GET /xampp/status.php HTTP/1.1" 200 3891 "http://cadenza/xampp/navi.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0"
127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] "GET /xampp/status.php HTTP/1.1" 200 3891 "http://cadenza/xampp/navi.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0"
127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] "GET /xampp/status.php HTTP/1.1" 200 3891 "http://cadenza/xampp/navi.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0"
127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] "GET /xampp/status.php HTTP/1.1" 200 3891 "http://cadenza/xampp/navi.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0"
```

- filter.conf

```bash
input {
  file {
    path => "/tmp/access.log"
    start_position => "beginning"
  }
}

filter {
  grok {
    match => { "message" => "%{COMBINEDAPACHELOG}" }
  }
  date {
    match => [ "timestamp" , "dd/MMM/yyyy:HH:mm:ss Z" ]
  }
}

output {
  stdout { codec => rubydebug }
}
```

- Start using the docker-compose file

```bash
$ docker-compose up
.
.
.
logstash-sandbox    | {"level":"INFO","loggerName":"logstash.agent","timeMillis":1594974961328,"thread":"Api Webserver","logEvent":{"message":"Successfully started Logstash API endpoint","port":9600}}
logstash-sandbox    | /usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/awesome_print-1.7.0/lib/awesome_print/formatters/base_formatter.rb:31: warning: constant ::Fixnum is deprecated
logstash-sandbox    | {
logstash-sandbox    |           "ident" => "-",
logstash-sandbox    |         "request" => "/xampp/status.php",
logstash-sandbox    |        "clientip" => "127.0.0.1",
logstash-sandbox    |        "@version" => "1",
logstash-sandbox    |        "response" => "200",
logstash-sandbox    |         "message" => "127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] \"GET /xampp/status.php HTTP/1.1\" 200 3891 \"http://cadenza/xampp/navi.php\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0\"",
logstash-sandbox    |            "auth" => "-",
logstash-sandbox    |            "path" => "/tmp/access.log",
logstash-sandbox    |           "bytes" => "3891",
logstash-sandbox    |      "@timestamp" => 2013-12-11T08:01:45.000Z,
logstash-sandbox    |            "verb" => "GET",
logstash-sandbox    |            "host" => "8ab5d2b292ee",
logstash-sandbox    |       "timestamp" => "11/Dec/2013:00:01:45 -0800",
logstash-sandbox    |        "referrer" => "\"http://cadenza/xampp/navi.php\"",
logstash-sandbox    |     "httpversion" => "1.1",
logstash-sandbox    |           "agent" => "\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0\""
logstash-sandbox    | }
logstash-sandbox    | {
logstash-sandbox    |           "ident" => "-",
logstash-sandbox    |         "request" => "/xampp/status.php",
logstash-sandbox    |        "clientip" => "127.0.0.1",
logstash-sandbox    |        "@version" => "1",
logstash-sandbox    |        "response" => "200",
logstash-sandbox    |         "message" => "127.0.0.1 - - [11/Dec/2013:00:01:45 -0800] \"GET /xampp/status.php HTTP/1.1\" 200 3891 \"http://cadenza/xampp/navi.php\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0\"",
logstash-sandbox    |            "auth" => "-",
logstash-sandbox    |            "path" => "/tmp/access.log",
logstash-sandbox    |           "bytes" => "3891",
logstash-sandbox    |      "@timestamp" => 2013-12-11T08:01:45.000Z,
logstash-sandbox    |            "verb" => "GET",
logstash-sandbox    |            "host" => "8ab5d2b292ee",
logstash-sandbox    |       "timestamp" => "11/Dec/2013:00:01:45 -0800",
logstash-sandbox    |        "referrer" => "\"http://cadenza/xampp/navi.php\"",
logstash-sandbox    |     "httpversion" => "1.1",
logstash-sandbox    |           "agent" => "\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:25.0) Gecko/20100101 Firefox/25.0\""
logstash-sandbox    | }
.
.
.
```