# [TCP Traffic Shifting](https://istio.io/latest/docs/tasks/traffic-management/tcp-traffic-shifting)

This task shows you how to shift TCP traffic from one version of a microservice to another.

In this task, you will send 100% of the TCP traffic to tcp-echo:v1. Then, you will route 20% of the TCP traffic to tcp-echo:v2 using Istio’s weighted routing feature.

## [Before you begin](https://istio.io/latest/docs/tasks/traffic-management/tcp-traffic-shifting/#before-you-begin)

## [Set up the test environment](https://istio.io/latest/docs/tasks/traffic-management/tcp-traffic-shifting/#set-up-the-test-environment)

To get started, create a namespace for testing TCP traffic shifting.

```bash
kubectl create namespace istio-io-tcp-traffic-shifting
```

Deploy the sleep sample app to use as a test source for sending requests.

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/sleep/sleep.yaml -n istio-io-tcp-traffic-shifting
```

Deploy the v1 and v2 versions of the tcp-echo microservice.

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/tcp-echo/tcp-echo-services.yaml -n istio-io-tcp-traffic-shifting
```

## [Apply weight-based TCP routing](https://istio.io/latest/docs/tasks/traffic-management/tcp-traffic-shifting/#apply-weight-based-tcp-routing)

Route all TCP traffic to the v1 version of the tcp-echo microservice.

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/tcp-echo/tcp-echo-all-v1.yaml -n istio-io-tcp-traffic-shifting
```

Determine the ingress IP and port:

```bash
export INGRESS_NAME=istio-ingressgateway
export INGRESS_NS=istio-system
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS"
export TCP_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')
```

Confirm that the tcp-echo service is up and running by sending some TCP traffic.

```bash
export SLEEP=$(kubectl get pod -l app=sleep -n istio-io-tcp-traffic-shifting -o jsonpath={.items..metadata.name})
# Loop
for i in {1..20}; do \
kubectl exec "$SLEEP" -c sleep -n istio-io-tcp-traffic-shifting -- sh -c "(date; sleep 1) | nc $INGRESS_HOST $TCP_INGRESS_PORT"; \
done
# Output
# one Thu Feb  8 15:29:09 UTC 2024
# one Thu Feb  8 15:29:15 UTC 2024
# one Thu Feb  8 15:29:20 UTC 2024
# .
```

You should notice that all the timestamps have a prefix of one, which means that all traffic was routed to the v1 version of the tcp-echo service.

Transfer 20% of the traffic from tcp-echo:v1 to tcp-echo:v2 with the following command:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/tcp-echo/tcp-echo-20-v2.yaml -n istio-io-tcp-traffic-shifting
```

Send some more TCP traffic to the tcp-echo microservice.

```bash
export SLEEP=$(kubectl get pod -l app=sleep -n istio-io-tcp-traffic-shifting -o jsonpath={.items..metadata.name})
# Loop
for i in {1..20}; do \
kubectl exec "$SLEEP" -c sleep -n istio-io-tcp-traffic-shifting -- sh -c "(date; sleep 1) | nc $INGRESS_HOST $TCP_INGRESS_PORT"; \
done
##  Output
# one Thu Feb  8 15:41:20 UTC 2024
# one Thu Feb  8 15:41:26 UTC 2024
# one Thu Feb  8 15:41:31 UTC 2024
# two Thu Feb  8 15:41:36 UTC 2024
# two Thu Feb  8 15:41:42 UTC 2024
# one Thu Feb  8 15:41:47 UTC 2024
# one Thu Feb  8 15:41:52 UTC 2024
# one Thu Feb  8 15:41:57 UTC 2024
# one Thu Feb  8 15:42:04 UTC 2024
# one Thu Feb  8 15:42:08 UTC 2024
```

## [Understanding what happened](https://istio.io/latest/docs/tasks/traffic-management/tcp-traffic-shifting/#understanding-what-happened)

## [Cleanup](https://istio.io/latest/docs/tasks/traffic-management/tcp-traffic-shifting/#cleanup)

```bash
# Remove the routing rules:
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/tcp-echo/tcp-echo-all-v1.yaml -n istio-io-tcp-traffic-shifting
# Remove the sleep sample, tcp-echo application and test namespace:
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/sleep/sleep.yaml -n istio-io-tcp-traffic-shifting
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/tcp-echo/tcp-echo-services.yaml -n istio-io-tcp-traffic-shifting
kubectl delete namespace istio-io-tcp-traffic-shifting
```
