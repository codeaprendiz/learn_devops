package main

import (
	"fmt"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Create a Prometheus counter
var pingCounter = prometheus.NewCounter(
	prometheus.CounterOpts{
		Name: "ping_request_count",
		Help: "No of request handled by Ping handler",
	},
)

func ping(w http.ResponseWriter, req *http.Request) {
	pingCounter.Inc() // Update the ping Handler to increase the count of the counter using pingCounter.Inc().
	fmt.Fprintf(w, "pong")
}

func main() {
	prometheus.MustRegister(pingCounter) // The prometheus.MustRegister function registers the pingCounter to the default Register. To expose the metrics the Go Prometheus client library provides the promhttp package.

	http.HandleFunc("/ping", ping)
	http.Handle("/metrics", promhttp.Handler()) // promhttp.Handler() provides a http.Handler which exposes the metrics registered in the Default Register.
	http.ListenAndServe(":8090", nil)
}
