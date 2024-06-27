# [Accessing External Services](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-control/)

This task shows you how to access external services in three different ways:

- Allow the Envoy proxy to pass requests through to services that are not configured inside the mesh.
- Configure service entries to provide controlled access to external services.
- Completely bypass the Envoy proxy for a specific range of IPs.

<br>

## [Before you begin](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-control/#before-you-begin)

Deploy the sleep sample app to use as a test source for sending requests. If you have automatic sidecar injection enabled, run the following command to deploy the sample app:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/sleep/sleep.yaml
```

Set the SOURCE_POD environment variable to the name of your source pod:

```bash
export SOURCE_POD=$(kubectl get pod -l app=sleep -o jsonpath='{.items..metadata.name}')

```

<br>

## [Envoy passthrough to external services](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-control/#envoy-passthrough-to-external-services)

To see this approach in action you need to ensure that your Istio installation is configured with the meshConfig.outboundTrafficPolicy.mode option set to ALLOW_ANY. Unless you explicitly set it to REGISTRY_ONLY mode when you installed Istio, it is probably enabled by default.

```bash
kubectl get istiooperator installed-state -n istio-system -o jsonpath='{.spec.meshConfig.outboundTrafficPolicy.mode}'
# You should either see ALLOW_ANY or no output (default ALLOW_ANY).
```

Make a couple of requests to external HTTPS services from the SOURCE_POD to confirm successful 200 responses:

```bash
kubectl exec "$SOURCE_POD" -c sleep -- curl -sSI https://www.google.com | grep  "HTTP/"; kubectl exec "$SOURCE_POD" -c sleep -- curl -sI https://edition.cnn.com | grep "HTTP/"
# Output
# HTTP/2 200 
# HTTP/2 200
```

<br>

## [Controlled access to external services](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-control/#controlled-access-to-external-services)

To demonstrate the controlled way of enabling access to external services, you need to change the meshConfig.outboundTrafficPolicy.mode option from the ALLOW_ANY mode to the REGISTRY_ONLY mode.

Change the meshConfig.outboundTrafficPolicy.mode option to REGISTRY_ONLY.

```bash
istioctl install --set profile=demo --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY -y
```

```bash
kubectl get istiooperator installed-state -n istio-system -o jsonpath='{.spec.meshConfig.outboundTrafficPolicy.mode}'
# REGISTRY_ONLY
```

Make a couple of requests to external HTTPS services from SOURCE_POD to verify that they are now blocked:

```bash
kubectl exec "$SOURCE_POD" -c sleep -- curl -sI https://www.google.com | grep  "HTTP/"; kubectl exec "$SOURCE_POD" -c sleep -- curl -sI https://edition.cnn.com | grep "HTTP/"
# command terminated with exit code 35
# command terminated with exit code 35
```

Access an external HTTP service

Create a ServiceEntry to allow access to an external HTTP service.

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: httpbin-ext
spec:
  hosts:
  - httpbin.org
  ports:
  - number: 80
    name: http
    protocol: HTTP
  resolution: DNS
  location: MESH_EXTERNAL
EOF

```

Make a request to the external HTTP service from SOURCE_POD:

```bash
kubectl exec "$SOURCE_POD" -c sleep -- curl -sS http://httpbin.org/headers

```

Output

```bash
# Note the headers added by the Istio sidecar proxy: X-Envoy-Decorator-Operation.
{
  "headers": {
    "Accept": "*/*",
    "Host": "httpbin.org",
    ...
    "X-Envoy-Decorator-Operation": "httpbin.org:80/*",
    ...
  }
}
```

Access an external HTTPS service

Create a ServiceEntry to allow access to an external HTTPS service.

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: google
spec:
  hosts:
  - www.google.com
  ports:
  - number: 443
    name: https
    protocol: HTTPS
  resolution: DNS
  location: MESH_EXTERNAL
EOF
```

Make a request to the external HTTPS service from SOURCE_POD:

```bash
kubectl exec "$SOURCE_POD" -c sleep -- curl -sSI https://www.google.com | grep  "HTTP/"
```

Output

```bash
HTTP/2 200 
```

Check the log of the sidecar proxy of SOURCE_POD:

```bash
<br>

## First one is Blocked request
[2024-02-14T11:07:41.017Z] "- - -" 0 UH - - "-" 0 0 0 - "-" "-" "-" "-" "-" BlackHoleCluster - 209.85.200.99:443 10.8.1.35:54818 - -
<br>

## This is after making the change
[2024-02-14T11:07:59.286Z] "- - -" 0 - - - "-" 844 5214 95 - "-" "-" "-" "-" "209.85.200.147:443" outbound|443||www.google.com 10.8.1.35:38416 209.85.200.147:443 10.8.1.35:38412 www.google.com -
```

Manage traffic to external services

Similar to inter-cluster requests, Istio routing rules can also be set for external services that are accessed using ServiceEntry configurations. In this example, you set a timeout rule on calls to the httpbin.org service.

From inside the pod being used as the test source, make a curl request to the /delay endpoint of the httpbin.org external service:

```bash
kubectl exec "$SOURCE_POD" -c sleep -- time curl -o /dev/null -sS -w "%{http_code}\n" http://httpbin.org/delay/5

```

Output

```bash
200
real    0m 5.09s
user    0m 0.00s
sys     0m 0.00s
```

Use kubectl to set a 3s timeout on calls to the httpbin.org external service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin-ext
spec:
  hosts:
    - httpbin.org
  http:
  - timeout: 3s
    route:
      - destination:
          host: httpbin.org
        weight: 100
EOF

```

Wait a few seconds, then make the curl request again:

```bash
kubectl exec "$SOURCE_POD" -c sleep -- time curl -o /dev/null -sS -w "%{http_code}\n" http://httpbin.org/delay/5
```

Output

```bash
504
real    0m 3.04s
user    0m 0.00s
sys     0m 0.00s
```

Cleanup the controlled access to external services

```bash
kubectl delete serviceentry httpbin-ext google
kubectl delete virtualservice httpbin-ext --ignore-not-found=true

```

Direct access to external services

If you want to completely bypass Istio for a specific IP range, you can configure the Envoy sidecars to prevent them from intercepting external requests. To set up the bypass, change either the global.proxy.includeIPRanges or the global.proxy.excludeIPRanges configuration option and update the istio-sidecar-injector configuration map using the kubectl apply command. This can also be configured on a pod by setting corresponding annotations such as traffic.sidecar.istio.io/includeOutboundIPRanges. After updating the istio-sidecar-injector configuration, it affects all future application pod deployments.

A simple way to exclude all external IPs from being redirected to the sidecar proxy is to set the global.proxy.includeIPRanges configuration option to the IP range or ranges used for internal cluster services. These IP range values depend on the platform where your cluster runs.

Determine the internal IP ranges for your platform

Set the value of `values.global.proxy.includeIPRanges` according to your cluster provider.

Configuring the proxy bypass

> Remove the service entry and virtual service previously deployed in this guide.

Update your istio-sidecar-injector configuration map using the IP ranges specific to your platform. For example, if the range is 10.0.0.1/24, use the following command:

```bash
istioctl install --set profile=demo --set values.global.proxy.includeIPRanges="10.0.0.1/24" 
```

```bash
kubectl exec "$SOURCE_POD" -c sleep -- curl -sS http://httpbin.org/headers
```

Output before deleting the source pod

```bash
{
  "headers": {
    "Accept": "*/*", 
    "Host": "httpbin.org", 
    "User-Agent": "curl/8.6.0", 
    "X-Amzn-Trace-Id": "Root=1-65cca619-xxxxxxxx", 
    "X-B3-Sampled": "1", 
    "X-B3-Spanid": "xxxxx", 
    "X-B3-Traceid": "xxxxx", 
    "X-Envoy-Attempt-Count": "1", 
    "X-Envoy-Peer-Metadata": "xxxxxxxx", 
    "X-Envoy-Peer-Metadata-Id": "sidecar~1xxxxxxx8c89.default~default.svc.cluster.local"
  }
}
```

After deleting the pod

```bash
$ kubectl get pods                                                                                                     
NAME                    READY   STATUS    RESTARTS   AGE
sleep-9454cc476-l8c89   2/2     Running   0          43m

$ kubectl delete pod sleep-9454cc476-l8c89             
pod "sleep-9454cc476-l8c89" deleted

$ export SOURCE_POD=$(kubectl get pod -l app=sleep -o jsonpath='{.items..metadata.name}')

kubectl exec "$SOURCE_POD" -c sleep -- curl -sS http://httpbin.org/headers

{
  "headers": {
    "Accept": "*/*", 
    "Host": "httpbin.org", 
    "User-Agent": "curl/8.6.0", 
    "X-Amzn-Trace-Id": "Root=1-65cca6c5-xxxxxxxxx"
  }
}
```

Unlike accessing external services through HTTP or HTTPS, you don’t see any headers related to the Istio sidecar and the requests sent to external services do not appear in the log of the sidecar. Bypassing the Istio sidecars means you can no longer monitor the access to external services.

<br>

## Cleanup the direct access to external services

```bash
istioctl install --set profile=demo -y 
```

<br>

## Cleanup

```bash
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/sleep/sleep.yaml
```
