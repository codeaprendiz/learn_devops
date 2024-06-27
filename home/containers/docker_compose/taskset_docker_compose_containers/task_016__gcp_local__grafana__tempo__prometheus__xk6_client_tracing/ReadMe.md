# [grafana / tempo](https://github.com/grafana/tempo/blob/main/example/docker-compose/local/readme.md)

<br>

## What is [grafana/tempo](https://github.com/grafana/tempo)

- Grafana Tempo is a high volume, minimal dependency distributed tracing backend.
- is deeply integrated with Grafana, Prometheus, and Loki
- is Jaeger, Zipkin, Kafka, OpenCensus and OpenTelemetry compatible.
- It ingests batches in different formats, buffers them and then writes them to Azure, GCS, S3 or local disk
- implements TraceQL, a traces-first query language inspired by LogQL and PromQL. 

<br>

## Task

```bash
$ cat /etc/os-release | egrep "PRETTY_NAME"
PRETTY_NAME="Ubuntu 20.04.6 LTS"

# Architecture
$ uname -m
x86_64 # 64-bit architecture, amd64
```

Start up the local stack.

```bash
docker compose up -d
```

<br>

## Accessing Grafana Tempo Service Graph

PUBLIC_IP:3000 -> Grafana -> Explore -> Tempo -> Service Graph

The data is coming from the [grafana/xk6-client-tracing](https://github.com/grafana/xk6-client-tracing) client which is a [grafana/k6](https://github.com/grafana/k6) extension for testing distributed tracing backends

You can check the services [here](https://github.com/grafana/xk6-client-tracing/blob/e340ce862e2f8faa07cf3333864e3ae2d2fd183e/examples/template/template.js#L29)
