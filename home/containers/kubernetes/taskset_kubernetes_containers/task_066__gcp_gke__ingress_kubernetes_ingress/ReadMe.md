# [Kubernetes Ingress](https://istio.io/latest/docs/tasks/traffic-management/ingress/kubernetes-ingress/)

This task describes how to configure Istio to expose a service outside of the service mesh cluster, using the Kubernetes Ingress Resource.

Start the httpbin sample, which will serve as the target service for ingress traffic:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml
```

```bash
export INGRESS_NAME=istio-ingressgateway                                                                                      
export INGRESS_NS=istio-system    
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS"
```

```bash
export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export TCP_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')
```

## [Configuring ingress using an Ingress resource](https://istio.io/latest/docs/tasks/traffic-management/ingress/kubernetes-ingress/#configuring-ingress-using-an-ingress-resource)

Create an Ingress resource:

The kubernetes.io/ingress.class annotation is required to tell the Istio gateway controller that it should handle this Ingress, otherwise it will be ignored.

```bash
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: istio
  name: ingress
spec:
  rules:
  - host: httpbin.example.com
    http:
      paths:
      - path: /status
        pathType: Prefix
        backend:
          service:
            name: httpbin
            port:
              number: 8000
EOF

```

Access the httpbin service using curl:

```bash
curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/status/200"

```

Output

```bash
HTTP/1.1 200 OK
server: istio-envoy
date: Wed, 14 Feb 2024 10:30:13 GMT
content-type: text/html; charset=utf-8
access-control-allow-origin: *
access-control-allow-credentials: true
content-length: 0
x-envoy-upstream-service-time: 21
```

Access any other URL that has not been explicitly exposed. You should see an HTTP 404 error:

```bash
curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/headers"
```

Output

```bash
HTTP/1.1 404 Not Found
date: Wed, 14 Feb 2024 10:30:38 GMT
server: istio-envoy
transfer-encoding: chunked
```

## [Specifying Ingressclass](https://istio.io/latest/docs/tasks/traffic-management/ingress/kubernetes-ingress/#specifying-ingressclass)

## Cleanup

```bash
kubectl delete ingress ingress
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml
```
