# [Request Routing](https://istio.io/latest/docs/tasks/traffic-management/request-routing/)

## [Prequisite](https://istio.io/latest/docs/tasks/traffic-management/request-routing/#before-you-begin)

[Deploying Bookinfo Application](https://istio.io/latest/docs/examples/bookinfo)

```bash
kubectl apply -f destination-rule-all.yaml 
```

This task shows you how to route requests dynamically to multiple versions of a microservice.

[Route to version 1](https://istio.io/latest/docs/tasks/traffic-management/request-routing/#route-to-version-1)

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/bookinfo/networking/virtual-service-all-v1.yaml
```

Display the defined routes with the following command:

```bash
## Make sure you have applied the destination rules before this
$ kubectl get virtualservices -o yaml
- apiVersion: networking.istio.io/v1beta1
  kind: VirtualService
  ...
  spec:
    hosts:
    - details
    http:
    - route:
      - destination:
          host: details
          subset: v1
- apiVersion: networking.istio.io/v1beta1
  kind: VirtualService
  ...
  spec:
    hosts:
    - productpage
    http:
    - route:
      - destination:
          host: productpage
          subset: v1
- apiVersion: networking.istio.io/v1beta1
  kind: VirtualService
  ...
  spec:
    hosts:
    - ratings
    http:
    - route:
      - destination:
          host: ratings
          subset: v1
- apiVersion: networking.istio.io/v1beta1
  kind: VirtualService
  ...
  spec:
    hosts:
    - reviews
    http:
    - route:
      - destination:
          host: reviews
          subset: v1
```

You have configured Istio to route to the v1 version of the Bookinfo microservices, most importantly the reviews service version 1.

You can easily test the new configuration by once again refreshing the /productpage of the Bookinfo app in your browser. Notice that the reviews part of the page displays with no rating stars, no matter how many times you refresh. This is because you configured Istio to route all traffic for the reviews service to the version reviews:v1 and this version of the service does not access the star ratings service.

[Route based on user identity](https://istio.io/latest/docs/tasks/traffic-management/request-routing/#route-based-on-user-identity)

Next, you will change the route configuration so that all traffic from a specific user is routed to a specific service version. In this case, all traffic from a user named Jason will be routed to the service reviews:v2.

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
```

## Cleanup

```bash
kubectl delete -f virtual-service-all-v1.yaml
```
