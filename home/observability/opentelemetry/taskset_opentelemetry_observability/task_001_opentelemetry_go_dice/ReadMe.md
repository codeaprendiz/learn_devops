# [Opentelemetry Go Dice](https://opentelemetry.io/docs/languages/go/getting-started)

This is a simple example of how to use the OpenTelemetry Go SDK to instrument a simple Go application.

## [Run](https://opentelemetry.io/docs/languages/go/getting-started/#run-the-application)

```bash
# Terminal 1
$ export OTEL_RESOURCE_ATTRIBUTES="service.name=dice,service.version=0.1.0"
$ go run .
.
.

# Terminal 2
$ curl localhost:8080/rolldice
3

```
