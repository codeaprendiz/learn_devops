# [Getting started with prometheus](https://prometheus.io/docs/tutorials/getting_started)

[prometheus.io » Getting started with prometheus](https://prometheus.io/docs/tutorials/getting_started)

- [Getting started with prometheus](#getting-started-with-prometheus)
  - [Running Using Docker](#running-using-docker)
  - [Accessing metrics via curl](#accessing-metrics-via-curl)
  - [Prometheus UI](#prometheus-ui)
  - [Download node exporter for scraping machine metrics](#download-node-exporter-for-scraping-machine-metrics)
  - [Scraping additional metrics](#scraping-additional-metrics)

## Running Using Docker

[prometheus.io » Using Docker](https://prometheus.io/docs/prometheus/latest/installation)

```bash
docker run --rm \
    -p 9090:9090 \
    -v ./prometheus_1.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
```

## Accessing metrics via curl

```bash
$ curl --silent http://localhost:9090/metrics | head -n 6 | egrep -v "#"
go_gc_duration_seconds{quantile="0"} 4.7708e-05
go_gc_duration_seconds{quantile="0.25"} 6.4833e-05
go_gc_duration_seconds{quantile="0.5"} 0.000225082
go_gc_duration_seconds{quantile="0.75"} 0.000323459
```

## Prometheus UI

[http://localhost:9090](http://localhost:9090)

## Download node exporter for scraping machine metrics

[prometheus.io » download » node_exporter](https://prometheus.io/download/#node_exporter)

```bash
./node_exporter
```

## Scraping additional metrics

[stackoverflow.com » How to access host port from docker container](https://stackoverflow.com/questions/31324981/how-to-access-host-port-from-docker-container)

```bash
docker run --rm \
    -p 9090:9090 \
    -v ./prometheus_2.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
```

- Check the status of targets

```bash
$ curl -s http://localhost:9090/api/v1/targets | jq '.data.activeTargets[] | {target: .labels.instance, status: .health}'

{
  "target": "host.docker.internal:9100",
  "status": "up"
}
{
  "target": "localhost:9090",
  "status": "up"
}
```