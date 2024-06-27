# [Instrumenting HTTP Server in GO](https://prometheus.io/docs/tutorials/instrumenting_http_server_in_go)

[prometheus.io » Instrumenting HTTP Server in GO](https://prometheus.io/docs/tutorials/instrumenting_http_server_in_go)

```bash
go mod init prom_example
go mod tidy
go run server.go
```

<br>

## Validation

```bash
$ curl localhost:8090/ping                   
pong

$ curl localhost:8090/ping                   
pong

$ curl --silent localhost:8090/metrics | egrep "ping_request_count"
# HELP ping_request_count No of request handled by Ping handler
# TYPE ping_request_count counter
ping_request_count 2
```

<br>

## Running Prometheus

```bash
docker run --rm \
    -p 9090:9090 \
    -v ./prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
```

<br>

## Check the status of targets

```bash
$ curl -s http://localhost:9090/api/v1/targets | jq '.data.activeTargets[] | {target: .labels.instance, status: .health}'
{
  "target": "localhost:9090",
  "status": "up"
}
{
  "target": "host.docker.internal:8090",
  "status": "up"
}
```

<br>

## Check the value of our metric

```bash
$ curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=ping_request_count' | \
  jq -r '.data.result[] | {instance: .metric.instance, value: .value[1]}'
{
  "instance": "host.docker.internal:8090",
  "value": "2"
}
```
