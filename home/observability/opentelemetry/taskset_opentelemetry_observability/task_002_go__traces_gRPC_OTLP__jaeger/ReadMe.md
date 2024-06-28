# Golang Example: Sending Traces to jaeger via grpc

## [opentelemetry.io » jaeger reference](https://opentelemetry.io/docs/languages/go/exporters/#jaeger)

- To try out the OTLP exporter, since v1.35.0 you can run Jaeger as an OTLP endpoint and for trace visualization in a Docker container:

```bash
docker run -d --name jaeger \
  -e COLLECTOR_OTLP_ENABLED=true \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  jaegertracing/all-in-one:latest
```

## [opentelemetry.io » oltp](https://opentelemetry.io/docs/languages/go/exporters/#otlp)

[otel-collector example](https://github.com/open-telemetry/opentelemetry-go/tree/main/example/otel-collector)

## How to run this?

```bash
$ go mod init go_traces_grpc_jaeger
go: creating new go.mod: module go_traces_grpc_jaeger
go: to add module requirements and sums:
        go mod tidy
...

$ go mod tidy
...

$ go run .
2024/03/11 13:34:43 Waiting for connection...
2024/03/11 13:34:43 Doing really hard work (1 / 10)
2024/03/11 13:34:44 Doing really hard work (2 / 10)
2024/03/11 13:34:45 Doing really hard work (3 / 10)
2024/03/11 13:34:46 Doing really hard work (4 / 10)
2024/03/11 13:34:47 Doing really hard work (5 / 10)
2024/03/11 13:34:48 Doing really hard work (6 / 10)
2024/03/11 13:34:49 Doing really hard work (7 / 10)
2024/03/11 13:34:50 Doing really hard work (8 / 10)
2024/03/11 13:34:51 Doing really hard work (9 / 10)
2024/03/11 13:34:52 Doing really hard work (10 / 10)
2024/03/11 13:34:53 Done!
```

## Access the jaeger dashboard [http://localhost:16686](http://localhost:16686)

## Flow

```bash
App + SDK ---> OpenTelemetry Collector  -----> Jaeger (trace)                                   
```
