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

```bash
$ curl -s -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=prometheus_http_request_duration_seconds_bucket{handler="/graph"}' | jq

{
  "status": "success",
  "data": {
    "resultType": "vector",
    "result": [
      {
        "metric": {
          "__name__": "prometheus_http_request_duration_seconds_bucket",
          "handler": "/graph",
          "instance": "localhost:9090",
          "job": "prometheus",
          "le": "+Inf"                     # indicates that this bucket includes all request durations. There is no upper limit to the durations captured in this bucket.
        },
        "value": [
          1702226077.077,
          "3"
        ]
      },
      {
        "metric": {
          "__name__": "prometheus_http_request_duration_seconds_bucket",
          "handler": "/graph",
          "instance": "localhost:9090",
          "job": "prometheus",
          "le": "0.1"                        # indicates that this bucket includes HTTP request durations that are less than or equal to 0.1 seconds.
        },
        "value": [
          1702226077.077,
          "3"
        ]
      },
      {
        "metric": {
          "__name__": "prometheus_http_request_duration_seconds_bucket",
          "handler": "/graph",
          "instance": "localhost:9090",
          "job": "prometheus",
          "le": "0.2"                         # indicates that this bucket includes HTTP request durations that are less than or equal to 0.2 seconds.
        },
        "value": [
          1702226077.077,
          "3"                                  # The value 3 suggests that there have been 3 HTTP requests for the /graph handler that had a duration of 0.2 seconds or less, up to the timestamp 1702226077.077.
        ]
      },
```

> HTTP Request Durations for /graph Handler

| Bucket (Request Duration Less than or equal to) | Number of Requests |
|-------------------------------------------------|--------------------|
| +Inf                                            | 3                  |
| 0.1s                                            | 3                  |
| 0.2s                                            | 3                  |

> HTTP Request Durations for /graph Handler

 Y Axis : Number of Requests
 X Axis : Bucket (Request Duration Less than or equal to)

3 |   ███    ███   ███
2 |   ███    ███   ███
1 |   ███    ███   ███
+------------------------
      +Inf   0.1s  0.2s

- The following shows that the 90th percentile is 0.09

```bash
$ curl --silent -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=histogram_quantile(0.9, prometheus_http_request_duration_seconds_bucket{handler="/graph"})' | jq

{
  "status": "success",       # This indicates that your query was successfully processed by the Prometheus server.
  "data": {
    "resultType": "vector",
    "result": [
      {
        "metric": {
          "handler": "/graph",       # This specifies the particular handler for which the data is relevant.
          "instance": "localhost:9090", # This is the address of the Prometheus instance from which the metric is collected.
          "job": "prometheus"  #  This specifies the job (in Prometheus terms) that generated the metric.
        },
        "value": [
          1702226928.954,              # The first element is a timestamp (1702226928.954), represented in Unix time format.
          "0.09000000000000001"        # The second element ("0.09000000000000001") represents the calculated value for the 90th percentile of the HTTP request durations for the /graph handler. In this case, it means that 90% of the HTTP requests to the /graph handler were completed in 0.09 seconds or less.
        ]
      }
    ]
  }
}
```

The query result tells you that for the `/graph` handler in your Prometheus-monitored system, 90% of the HTTP requests were processed within approximately 0.09 seconds as of the given timestamp.

To find the histogram_quantile over the last 5m you can use the rate() and time frame
After running this command, you will receive a JSON response from Prometheus with the calculated 90th percentile rate of the request durations for the /graph handler over the last 5 minutes.

```bash
$ curl --silent -G 'http://localhost:9090/api/v1/query' --data-urlencode 'query=histogram_quantile(0.9, rate(prometheus_http_request_duration_seconds_bucket{handler="/graph"}[5m]))' | jq
{
  "status": "success",
  "data": {
    "resultType": "vector",
    "result": [
      {
        "metric": {
          "handler": "/graph",
          "instance": "localhost:9090",
          "job": "prometheus"
        },
        "value": [
          1702227411.639,
          "NaN"           # The second element is NaN (Not a Number), indicating that the 90th percentile of the rate of request durations could not be calculated for the specified interval and conditions.
        ]
      }
    ]
  }
}
```