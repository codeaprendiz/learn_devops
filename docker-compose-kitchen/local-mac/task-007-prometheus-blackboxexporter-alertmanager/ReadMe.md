## Testing Prometheus alertmanager for the sending alerts to slack

[Docs Referred](https://grafana.com/blog/2020/02/25/step-by-step-guide-to-setting-up-prometheus-alertmanager-with-slack-pagerduty-and-gmail/)


### Dir structure

```bash
$ tree local-mac/task-007-prometheus-blackboxexporter-alertmanager 
local-mac/task-007-prometheus-blackboxexporter-alertmanager
├── ReadMe.md
├── alertmanager
│   └── configuration.yml
├── blackboxexporter
│   └── config.yml
├── docker-compose.yml
└── prometheus
    ├── alert.rules.yml
    └── prometheus.yml
```

- docker-compose.yaml

```yaml
version: '3.7'

networks:
  host:

services:
  prometheus:
    image: prom/prometheus:v2.18.1
    container_name: prometheus-sandbox
    volumes:
      - ${PWD}/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
      - ${PWD}/prometheus/alert.rules.yml:/etc/prometheus/alert.rules.yml
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/usr/share/prometheus/console_libraries'
      - '--web.console.templates=/usr/share/prometheus/consoles'
      - '--web.external-url=http://localhost:9090'
    ports:
      - 9090:9090
    networks:
      - host
    restart: always

  alertmanager:
    image: prom/alertmanager:v0.20.0
    container_name: alertmanager-sandbox
    links:
      - prometheus
    ports:
      - 9093:9093
    volumes:
      - ${PWD}/alertmanager/configuration.yml:/etc/alertmanager/config.yml
    networks:
      - host
    restart: always
    command:
      - '--config.file=/etc/alertmanager/config.yml'
      - '--storage.path=/alertmanager'


  blackboxexporter:
    restart: unless-stopped

    image: prom/blackbox-exporter:v0.17.0
    container_name: blackboxexporter
    environment:
      deployment: 'ec2'
    command:
      - '--config.file=/etc/blackboxexporter/config.yml'
    volumes:
      - ${PWD}/blackboxexporter/config.yml:/etc/blackboxexporter/config.yml
    networks:
      - host
    ports:
      - 9115:9115
```

- alertmanager/configuration.yml

```yaml
route:
  receiver: 'slack-critical'
  routes:
    - match:
        threshold: warning
      continue: true
      receiver: slack-warning
    - match:
        threshold: danger
      continue: true
      receiver: slack-danger
    - match:
        threshold: critical
      receiver: slack-critical


receivers:
  - name: 'slack-warning'
    slack_configs:
      - send_resolved: true
        username: 'hubot'
        icon_url: https://avatars3.githubusercontent.com/u/3380462
        pretext: '{{ .CommonAnnotations.summary }}'
        title: '[{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] Monitoring Event Notification'
        text: >-
          {{ range .Alerts }}
             *Alert:* {{ .Annotations.summary }} - `{{ .Labels.threshold }}`
             *Description:* {{ .Annotations.description }}
             *Graph:* <{{ .GeneratorURL }}|:chart_with_upwards_trend:>
             *Details:*
             {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
             {{ end }}
          {{ end }}
        channel: '#test-monitoring'
        api_url: 'https://hooks.slack.com/services/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'

  - name: 'slack-danger'
    slack_configs:
      - send_resolved: true
        username: 'hubot'
        icon_url: https://avatars3.githubusercontent.com/u/3380462
        pretext: '{{ .CommonAnnotations.summary }}'
        title: '[{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] Monitoring Event Notification'
        text: >-
          {{ range .Alerts }}
             *Alert:* {{ .Annotations.summary }} - `{{ .Labels.threshold }}`
             *Description:* {{ .Annotations.description }}
             *Graph:* <{{ .GeneratorURL }}|:chart_with_upwards_trend:>
             *Details:*
             {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
             {{ end }}
          {{ end }}
        channel: '#test-monitoring'
        api_url: 'https://hooks.slack.com/services/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'

  - name: 'slack-critical'
    slack_configs:
      - send_resolved: true
        username: 'hubot'
        icon_url: https://avatars3.githubusercontent.com/u/3380462
        pretext: '{{ .CommonAnnotations.summary }}'
        title: '[{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] Monitoring Event Notification'
        text: >-
          {{ range .Alerts }}
             *Alert:* {{ .Annotations.summary }} - `{{ .Labels.threshold }}`
             *Description:* {{ .Annotations.description }}
             *Graph:* <{{ .GeneratorURL }}|:chart_with_upwards_trend:>
             *Details:*
             {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
             {{ end }}
          {{ end }}
        channel: '#test-monitoring'
        api_url: 'https://hooks.slack.com/services/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'
```

- blackboxexporter/config.yml

```yaml
modules:
  http_2xx:
    prober: http
    http:
      preferred_ip_protocol: "ip4"
  http_post_2xx:
    prober: http
    http:
      method: POST
  tcp_connect:
    prober: tcp
  pop3s_banner:
    prober: tcp
    tcp:
      query_response:
        - expect: "^+OK"
      tls: true
      tls_config:
        insecure_skip_verify: false
  ssh_banner:
    prober: tcp
    tcp:
      query_response:
        - expect: "^SSH-2.0-"
  irc_banner:
    prober: tcp
    tcp:
      query_response:
        - send: "NICK prober"
        - send: "USER prober prober prober :prober"
        - expect: "PING :([^ ]+)"
          send: "PONG ${1}"
        - expect: "^:[^ ]+ 001"
  icmp:
    prober: icmp
```

- prometheus/alert.rules.yml

```yaml
groups:
  - name: alert.rules
    rules:
      - alert: service_down
        expr: probe_success == 0
        for: 1m
        labels:
          severity: 3
          threshold: critical
        annotations:
          summary: "Instance *{{ $labels.instance }}* down"
          description: "*{{ $labels.instance }}* of job *{{ $labels.job }}* is down"
```

- prometheus/prometheus.yml

```yaml
global:
  scrape_interval: 5s


# Rules and alerts are read from the specified file(s)
rule_files:
  - alert.rules.yml

# Alerting specifies settings related to the Alertmanager
alerting:
  alertmanagers:
    - static_configs:
        - targets:
            # Alertmanager's default port is 9093
            - host.docker.internal:9093

scrape_configs:
  - job_name: blackbox # To get metrics about the exporter itself
    metrics_path: /metrics
    static_configs:
      - targets:
          - host.docker.internal:9115   # For Windows and macOS replace with - host.docker.internal:9115

  - job_name: blackbox-http # To get metrics about the exporter’s targets
    metrics_path: /probe
    params:
      module: [http_2xx]
    static_configs:
      - targets:
          - http://prometheus.io    # Target to probe with http
          - https://prometheus.io   # Target to probe with https
          - http://example.com:8080 # Target to probe with http on port 8080
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: host.docker.internal:9115  # The blackbox exporter’s real hostname:port. For Windows and macOS replace with - host.docker.internal:9115
```


- Start the services using

```bash
$ docker-compose up -d
Creating network "11-prom-blackboxexporter-alertmanager_host" with the default driver
Creating prometheus-sandbox ... done
Creating blackboxexporter   ... done
Creating alertmanager-sandbox ... done
```

- Check the [http://localhost:9090/targets](http://localhost:9090/targets) are up


- Check the [http://localhost:9090/alerts](http://localhost:9090/alerts)

![](../../images/task-007-prometheus-blackboxexporter-alertmanager/alerts-page.png)


- Wait for 1 min and check if the Alerts move to Pending state. After this wait for 1 mins and check if the
alert moves to Firing state.


- You can also access the [http://localhost:9093/#/alerts](http://localhost:9093/#/alerts) and check the 
alerts (after they moved to firing state)

![](../../../images/docker-compose-kitchen/task-007-prometheus-blackboxexporter-alertmanager/alertmanager.png)

- Now you should receive a slack notification as shown below

![](../../../images/docker-compose-kitchen/task-007-prometheus-blackboxexporter-alertmanager/slack-alert-snapshot.png)

