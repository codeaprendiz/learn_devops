# [Instrumenting HTTP Server in GO](https://prometheus.io/docs/tutorials/instrumenting_http_server_in_go)

[prometheus.io » Instrumenting HTTP Server in GO](https://prometheus.io/docs/tutorials/instrumenting_http_server_in_go)

```bash
go mod init prom_example
go mod tidy
go run server.go
```

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


