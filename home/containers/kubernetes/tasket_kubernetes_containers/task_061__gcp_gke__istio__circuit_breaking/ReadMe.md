# [Circuit Breaking](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking)

## [Before you begin](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/#before-you-begin)

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml           
```

## [Configuring the circuit breaker](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/#configuring-the-circuit-breaker)

Create a destination rule to apply circuit breaking settings when calling the httpbin service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: httpbin
spec:
  host: httpbin
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 1
      http:
        http1MaxPendingRequests: 1
        maxRequestsPerConnection: 1
    outlierDetection:
      consecutive5xxErrors: 1
      interval: 1s
      baseEjectionTime: 3m
      maxEjectionPercent: 100
EOF
```

## [Adding a client](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/#adding-a-client)

Create a client to send traffic to the httpbin service. The client is a simple load-testing client called fortio. Fortio lets you control the number of connections, concurrency, and delays for outgoing HTTP calls. You will use this client to “trip” the circuit breaker policies you set in the DestinationRule. 

Inject the client with the Istio sidecar proxy so network interactions are governed by Istio.

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/sample-client/fortio-deploy.yaml
```

Log in to the client pod and use the fortio tool to call httpbin. Pass in curl to indicate that you just want to make one call:

```bash
export FORTIO_POD=$(kubectl get pods -l app=fortio -o 'jsonpath={.items[0].metadata.name}')
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio curl -quiet http://httpbin:8000/get
```

You can see the request succeeded! Now, it’s time to break something.

## [Tripping the circuit breaker](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/#tripping-the-circuit-breaker)

In the DestinationRule settings, you specified maxConnections: 1 and http1MaxPendingRequests: 1. These rules indicate that if you exceed more than one connection and request concurrently, you should see some failures when the istio-proxy opens the circuit for further requests and connections.

Call the service with two concurrent connections (-c 2) and send 20 requests (-n 20):

```bash
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio load -c 2 -qps 0 -n 20 -loglevel Warning http://httpbin:8000/get

# It’s interesting to see that almost all requests made it through! The istio-proxy does allow for some leeway.
# Code 200 : 13 (65.0 %)
# Code 503 : 7 (35.0 %)

```

Bring the number of concurrent connections up to 3:

```bash
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio load -c 3 -qps 0 -n 30 -loglevel Warning http://httpbin:8000/get
# Now you start to see the expected circuit breaking behavior. Only 36.7% of the requests succeeded and the rest were trapped by circuit breaking:
# Code 200 : 12 (40.0 %)
# Code 503 : 18 (60.0 %)
```

Query the istio-proxy stats to see more:

```bash
kubectl exec "$FORTIO_POD" -c istio-proxy -- pilot-agent request GET stats | grep httpbin | grep pending
# Output
# cluster.outbound|8000||httpbin.default.svc.cluster.local.circuit_breakers.default.remaining_pending: 1
# cluster.outbound|8000||httpbin.default.svc.cluster.local.circuit_breakers.default.rq_pending_open: 0
# cluster.outbound|8000||httpbin.default.svc.cluster.local.circuit_breakers.high.rq_pending_open: 0
# cluster.outbound|8000||httpbin.default.svc.cluster.local.upstream_rq_pending_active: 0
# cluster.outbound|8000||httpbin.default.svc.cluster.local.upstream_rq_pending_failure_eject: 0
# cluster.outbound|8000||httpbin.default.svc.cluster.local.upstream_rq_pending_overflow: 50
# cluster.outbound|8000||httpbin.default.svc.cluster.local.upstream_rq_pending_total: 51
## You can see 50 for the upstream_rq_pending_overflow value which means 50 calls so far have been flagged for circuit breaking.
```

## [Cleanup](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/#cleaning-up)

```bash
kubectl delete destinationrule httpbin
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/sample-client/fortio-deploy.yaml
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml
```
