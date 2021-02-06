## Black box exporter POC

[Docs](https://prometheus.io/docs/guides/multi-target-exporter/)

- Starting the blackbox exporter
```bash
$ docker run -p 9115:9115 prom/blackbox-exporter
level=info ts=2020-07-27T17:37:24.916Z caller=main.go:212 msg="Starting blackbox_exporter" version="(version=0.17.0, branch=HEAD, revision=1bc768014cf6815f7e9d694e0292e77dd10f3235)"
level=info ts=2020-07-27T17:37:24.916Z caller=main.go:213 msg="Build context" (gogo1.14.4,userroot@626fb3899f41,date20200619-11:54:41)=(MISSING)
level=info ts=2020-07-27T17:37:24.918Z caller=main.go:225 msg="Loaded config file"
level=info ts=2020-07-27T17:37:24.919Z caller=main.go:369 msg="Listening on address" address=:9115

```

- Quering the exporter itself
```bash
$ curl 'localhost:9115/metrics'
# HELP blackbox_exporter_build_info A metric with a constant '1' value labeled by version, revision, branch, and goversion from which blackbox_exporter was built.
.
promhttp_metric_handler_requests_total{code="503"} 0
```

- to query prometheus.io in the terminal with curl:

```bash
$ docker \
>   run -p 9115:9115 \
>   --mount type=bind,source="$(pwd)"/blackbox.yml,target=/blackbox.yml,readonly \
>   prom/blackbox-exporter \
>   --config.file="/blackbox.yml"
level=info ts=2020-07-27T18:06:49.187Z caller=main.go:212 msg="Starting blackbox_exporter" version="(version=0.17.0, branch=HEAD, revision=1bc768014cf6815f7e9d694e0292e77dd10f3235)"
level=info ts=2020-07-27T18:06:49.187Z caller=main.go:213 msg="Build context" (gogo1.14.4,userroot@626fb3899f41,date20200619-11:54:41)=(MISSING)
level=info ts=2020-07-27T18:06:49.190Z caller=main.go:225 msg="Loaded config file"
level=info ts=2020-07-27T18:06:49.190Z caller=main.go:369 msg="Listening on address" address=:9115
```

With this command, you told docker to:

- run a container with the port 9115 outside the container mapped to the port 9115 inside of the container.
- mount from your current directory ($(pwd) stands for print working directory) the file blackbox.yml into /blackbox.yml in readonly mode.
- use the image prom/blackbox-exporter from Docker hub.
- run the blackbox-exporter with the flag --config.file telling it to use /blackbox.yml as config file.

Now you can try our new IPv4-using module http_2xx in a terminal:
```bash
$ curl 'localhost:9115/probe?target=prometheus.io&module=http_2xx'
# HELP probe_dns_lookup_time_seconds Returns the time taken for probe dns lookup in seconds
.
probe_success 1
# HELP probe_tls_version_info Contains the TLS version used
# TYPE probe_tls_version_info gauge
probe_tls_version_info{version="TLS 1.3"} 1
```

Run Prometheus on MacOS
```bash
$ docker \
>   run -p 9090:9090 \
>   --mount type=bind,source="$(pwd)"/prometheus.yml,target=/prometheus.yml,readonly \
>   prom/prometheus \
>   --config.file="/prometheus.yml"
level=info ts=2020-07-27T18:23:09.768Z caller=main.go:302 msg="No time or size retention was set so using the default time retention" duration=15d
.
level=info ts=2020-07-27T18:23:09.791Z caller=main.go:646 msg="Server is ready to receive web requests."
```

If everything works fine, you can check the targets at [localhost:9090/targets](localhost:9090/targets)


![](../../../images/docker-kitchen/task-004-prom-blackbox-exporter/localhost-targets-prometheus.png)
