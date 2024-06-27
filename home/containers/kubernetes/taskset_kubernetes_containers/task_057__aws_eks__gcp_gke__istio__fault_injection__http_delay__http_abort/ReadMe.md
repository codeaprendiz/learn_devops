# [Fault Injection](https://istio.io/latest/docs/tasks/traffic-management/fault-injection)

<br>

## [Traffic Management](https://istio.io/latest/docs/concepts/traffic-management/)

<br>

## [Pre-requisite](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/#before-you-begin)

```bash
kubectl apply -f destination-rule-all.yaml
kubectl apply -f  virtual-service-all-v1.yaml
kubectl apply -f virtual-service-reviews-test-v2.yaml
```

With the above configuration, this is how requests flow:

- productpage → reviews:v2 → ratings (only for user jason)
- productpage → reviews:v1 (for everyone else)

<br>

## [Injecting an HTTP delay fault](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/#injecting-an-http-delay-fault)

To test the Bookinfo application microservices for resiliency, inject a 7s delay between the reviews:v2 and ratings microservices for user jason. This test will uncover a bug that was intentionally introduced into the Bookinfo app.

Note that the reviews:v2 service has a 10s hard-coded connection timeout for calls to the ratings service. Even with the 7s delay that you introduced, you still expect the end-to-end flow to continue without any errors

```bash
kubectl apply -f virtual-service-ratings-test-delay.yaml 
```

<br>

## [Testing the delay configuration](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/#testing-the-delay-configuration)

<br>

## [Understanding what happened](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/#understanding-what-happened)

<br>

## [Injecting an HTTP abort fault](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/#injecting-an-http-abort-fault)

```bash
kubectl apply -f virtual-service-ratings-test-abort.yaml 
```

<br>

## [Testing the abort configuration](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/#testing-the-abort-configuration)

<br>

## [Cleanup](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/#cleanup)

```bash
kubectl delete -f virtual-service-all-v1.yaml 
```
