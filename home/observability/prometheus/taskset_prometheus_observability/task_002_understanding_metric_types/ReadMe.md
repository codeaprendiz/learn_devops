# [Understanding metric types](https://prometheus.io/docs/tutorials/understanding_metric_types/)

[prometheus.io » Understanding metric types](https://prometheus.io/docs/tutorials/understanding_metric_types/)

## Counter

Counter is a metric value that can only increase or reset i.e. the value cannot reduce than the previous value. It can be used for metrics like the number of requests, no of errors, etc.

```bash
go_gc_duration_seconds_count
```

```bash
curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=go_gc_duration_seconds_count' | \
  jq -r '.data.result[] | {instance: .metric.instance, value: .value[1]}'

{
  "instance": "host.docker.internal:9100",
  "value": "23"
}
{
  "instance": "localhost:9090",
  "value": "22"
}
```

The rate() function in PromQL takes the history of metrics over a time frame and calculates how fast the value is increasing per second. Rate is applicable on counter values only.

```bash
$ curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=rate(go_gc_duration_seconds_count[5m])' | \
  jq -r '.data.result[] | {instance: .metric.instance, value: .value[1]}'

{
  "instance": "host.docker.internal:9100",
  "value": "0.021053000929840873"
}
{
  "instance": "localhost:9090",
  "value": "0.007017716224609026"
}
```

## Gauge

Gauge is a number which can either go up or down. It can be used for metrics like the number of pods in a cluster, the number of events in a queue, etc.

```bash
go_memstats_heap_alloc_bytes
```

```bash
$ curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=go_memstats_heap_alloc_bytes' | \
  jq -r '.data.result[] | {instance: .metric.instance, value: .value[1]}'

{
  "instance": "host.docker.internal:9100",
  "value": "2458736"
}
{
  "instance": "localhost:9090",
  "value": "22375256"
}
```

PromQL functions like max_over_time, min_over_time and avg_over_time can be used on gauge metrics

```bash
$ curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=max_over_time(go_memstats_heap_alloc_bytes[5m])' | jq -r '.data.result[] | {instance: .metric.instance, value: .value[1]}'

{
  "instance": "host.docker.internal:9100",
  "value": "2955736"
}
{
  "instance": "localhost:9090",
  "value": "31170800"
}
```

```bash
$ curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=min_over_time(go_memstats_heap_alloc_bytes[5m])' | jq -r '.data.result[] | {instance: .metric.instance, value: .value[1]}'
{
  "instance": "host.docker.internal:9100",
  "value": "1704312"
}
{
  "instance": "localhost:9090",
  "value": "20550824"
}
```

```bash
$ curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=avg_over_time(go_memstats_heap_alloc_bytes[5m])' | jq -r '.data.result[] | {instance: .metric.instance, value: .value[1]}'
{
  "instance": "host.docker.internal:9100",
  "value": "2244632.8"
}
{
  "instance": "localhost:9090",
  "value": "24582261.6"
}
```