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

## Histogram

Histogram is a more complex metric type when compared to the previous two. Histogram can be used for any calculated value which is counted based on bucket values. Bucket boundaries can be configured by the developer. A common example would be the time it takes to reply to a request, called latency.

Example: Let's assume we want to observe the time taken to process API requests. Instead of storing the request time for each request, histograms allow us to store them in buckets. We define buckets for time taken, for example lower or equal 0.3, le 0.5, le 0.7, le 1, and le 1.2. So these are our buckets and once the time taken for a request is calculated it is added to the count of all the buckets whose bucket boundaries are higher than the measured value.