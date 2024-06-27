# [Ingress Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control)

<br>

## [Before you begin](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#before-you-begin)

Start the httpbin sample, which will serve as the target service for ingress traffic:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml
```

<br>

## [Configuring ingress using a gateway](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#configuring-ingress-using-a-gateway)

An ingress Gateway describes a load balancer operating at the edge of the mesh that receives incoming HTTP/TCP connections. It configures exposed ports, protocols, etc. but, unlike Kubernetes Ingress Resources, does not include any traffic routing configuration. Traffic routing for ingress traffic is instead configured using routing rules, exactly in the same way as for internal service requests.

Let’s see how you can configure a Gateway on port 80 for HTTP traffic.

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  # The selector matches the ingress gateway pod labels.
  # If you installed Istio using Helm following the standard documentation, this would be "istio=ingress"
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "httpbin.example.com"
EOF

```

Configure routes for traffic entering via the Gateway:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "httpbin.example.com"
  gateways:
  - httpbin-gateway
  http:
  - match:
    - uri:
        prefix: /status
    - uri:
        prefix: /delay
    route:
    - destination:
        port:
          number: 8000
        host: httpbin
EOF

```

You have now created a virtual service configuration for the httpbin service containing two route rules that allow traffic for paths /status and /delay.

The gateways list specifies that only requests through your httpbin-gateway are allowed. All other external requests will be rejected with a 404 response.

<br>

## [Determining the ingress IP and ports](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#configuring-ingress-using-a-gateway)

Every Gateway is backed by a service of type LoadBalancer. The external load balancer IP and ports for this service are used to access the gateway

```bash
export INGRESS_NAME=istio-ingressgateway
export INGRESS_NS=istio-system
```

Run the following command to determine if your Kubernetes cluster is in an environment that supports external load balancers:

```bash
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS"
```

```bash
export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export TCP_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')

```

<br>

## [Accessing ingress services](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#accessing-ingress-services)

Access the httpbin service using curl:

```bash
curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/status/200"
# Output
# HTTP/1.1 200 OK
# server: istio-envoy
# date: Fri, 09 Feb 2024 16:46:13 GMT
# content-type: text/html; charset=utf-8
# access-control-allow-origin: *
# access-control-allow-credentials: true
# content-length: 0
# x-envoy-upstream-service-time: 14
```

Note that you use the -H flag to set the Host HTTP header to “httpbin.example.com”. This is needed because your ingress Gateway is configured to handle “httpbin.example.com”, but in your test environment you have no DNS binding for that host and are simply sending your request to the ingress IP.

Access any other URL that has not been explicitly exposed. You should see an HTTP 404 error:

```bash
curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/headers"
<br>

## Output
# HTTP/1.1 404 Not Found
# date: Fri, 09 Feb 2024 16:47:19 GMT
# server: istio-envoy
# transfer-encoding: chunked

```

<br>

## [Accessing ingress services using a browser](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#accessing-ingress-services-using-a-browser)

Use a wildcard * value for the host in the Gateway and VirtualService configurations. For example, change your ingress configuration to the following:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  # The selector matches the ingress gateway pod labels.
  # If you installed Istio using Helm following the standard documentation, this would be "istio=ingress"
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "*"
  gateways:
  - httpbin-gateway
  http:
  - match:
    - uri:
        prefix: /headers
    route:
    - destination:
        port:
          number: 8000
        host: httpbin
EOF

```

You can then use $INGRESS_HOST:$INGRESS_PORT in the browser URL. For example, http://$INGRESS_HOST:$INGRESS_PORT/headers will display all the headers that your browser sends.

<br>

## Cleanup

Delete the Gateway and VirtualService configuration, and shutdown the httpbin service:

```bash
kubectl delete gateway httpbin-gateway
kubectl delete virtualservice httpbin
kubectl delete --ignore-not-found=true -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml

```