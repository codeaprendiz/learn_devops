# [Request Timeouts](https://istio.io/latest/docs/tasks/traffic-management/request-timeouts/)

This task shows you how to set up request timeouts in Envoy using Istio.

<br>

## [Pre-requisite](https://istio.io/latest/docs/tasks/traffic-management/request-timeouts/#before-you-begin)

Setup Istio by following the instructions in the Installation guide.

Deploy the Bookinfo sample application including the service versions.

```bash
kubectl apply -f destination-rule-all.yaml
```

<br>

## [Request Timeouts](https://istio.io/latest/docs/tasks/traffic-management/request-timeouts/#request-timeouts)

Route requests to v2 of the reviews service, i.e., a version that calls the ratings service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v2
EOF
```

Add a 2 second delay to calls to the ratings service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: ratings
spec:
  hosts:
  - ratings
  http:
  - fault:
      delay:
        percentage:
          value: 100
        fixedDelay: 2s
    route:
    - destination:
        host: ratings
        subset: v1
EOF
```

You should see the Bookinfo application working normally (with ratings stars displayed), but there is a 2 second delay whenever you refresh the page.

Now add a half second request timeout for calls to the reviews service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v2
    timeout: 0.5s
EOF
```

You should now see that it returns in about 1 second, instead of 2, and the reviews are unavailable.

> The reason that the response takes 1 second, even though the timeout is configured at half a second, is because there is a hard-coded retry in the productpage service, so it calls the timing out reviews service twice before returning.

<br>

## Cleanup

```bash
kubectl delete -f virtual-service-all-v1.yaml 
```