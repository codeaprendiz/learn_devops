# [Traffic Shifting](https://istio.io/latest/docs/tasks/traffic-management/traffic-shifting/)

This task shows you how to shift traffic from one version of a microservice to another.

In this task, you will use send 50% of traffic to reviews:v1 and 50% to reviews:v3. Then, you will complete the migration by sending 100% of traffic to reviews:v3.

<br>

## [Apply weight-based routing](https://istio.io/latest/docs/tasks/traffic-management/traffic-shifting/#apply-weight-based-routing)

```bash
kubectl apply -f destination-rule-all.yaml
# you configured Istio to route all traffic for the reviews service to the version reviews:v1 and this version of the service does not access the star ratings service.
kubectl apply -f virtual-service-all-v1.yaml
```

Transfer 50% of the traffic from reviews:v1 to reviews:v3 with the following command:

```bash
kubectl apply -f virtual-service-reviews-50-v3.yaml
```

Refresh the /productpage in your browser and you now see red colored star ratings approximately 50% of the time

Assuming you decide that the reviews:v3 microservice is stable, you can route 100% of the traffic to reviews:v3 by applying this virtual service:

```bash
kubectl apply -f virtual-service-reviews-v3.yaml
```

Refresh the /productpage several times. Now you will always see book reviews with red colored star ratings for each review.

<br>

## Cleanup

```bash
kubectl delete -f virtual-service-all-v1.yaml 
```
