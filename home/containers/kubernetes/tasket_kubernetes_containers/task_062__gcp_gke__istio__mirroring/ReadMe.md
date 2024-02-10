# [Mirroring](https://istio.io/latest/docs/tasks/traffic-management/mirroring/)

Traffic mirroring, also called shadowing, is a powerful concept that allows feature teams to bring changes to production with as little risk as possible. Mirroring sends a copy of live traffic to a mirrored service. The mirrored traffic happens out of band of the critical request path for the primary service.

## [Before you begin](https://istio.io/latest/docs/tasks/traffic-management/mirroring/#before-you-begin)

Start by deploying two versions of the httpbin service that have access logging enabled:

httpbin-v1:

```bash
cat <<EOF | istioctl kube-inject -f - | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpbin-v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: httpbin
      version: v1
  template:
    metadata:
      labels:
        app: httpbin
        version: v1
    spec:
      containers:
      - image: docker.io/kennethreitz/httpbin
        imagePullPolicy: IfNotPresent
        name: httpbin
        command: ["gunicorn", "--access-logfile", "-", "-b", "0.0.0.0:80", "httpbin:app"]
        ports:
        - containerPort: 80
EOF
```

httpbin-v2:

```bash
cat <<EOF | istioctl kube-inject -f - | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpbin-v2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: httpbin
      version: v2
  template:
    metadata:
      labels:
        app: httpbin
        version: v2
    spec:
      containers:
      - image: docker.io/kennethreitz/httpbin
        imagePullPolicy: IfNotPresent
        name: httpbin
        command: ["gunicorn", "--access-logfile", "-", "-b", "0.0.0.0:80", "httpbin:app"]
        ports:
        - containerPort: 80
EOF
```

httpbin Kubernetes service:

```bash
kubectl create -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: httpbin
  labels:
    app: httpbin
spec:
  ports:
  - name: http
    port: 8000
    targetPort: 80
  selector:
    app: httpbin
EOF
```

Start the sleep service so you can use curl to provide load:

sleep service:

```bash
cat <<EOF | istioctl kube-inject -f - | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sleep
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sleep
  template:
    metadata:
      labels:
        app: sleep
    spec:
      containers:
      - name: sleep
        image: curlimages/curl
        command: ["/bin/sleep","3650d"]
        imagePullPolicy: IfNotPresent
EOF
```

## [Creating a default routing policy](https://istio.io/latest/docs/tasks/traffic-management/mirroring/#creating-a-default-routing-policy)

By default Kubernetes load balances across both versions of the httpbin service. In this step, you will change that behavior so that all traffic goes to v1.

Create a default route rule to route all traffic to v1 of the service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
    - httpbin
  http:
  - route:
    - destination:
        host: httpbin
        subset: v1
      weight: 100
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: httpbin
spec:
  host: httpbin
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
EOF

```

Now, with all traffic directed to httpbin:v1, send a request to the service:

```bash
export SLEEP_POD=$(kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name})
kubectl exec "${SLEEP_POD}" -c sleep -- curl -sS http://httpbin:8000/headers
```

Check the logs for v1 and v2 of the httpbin pods. You should see access log entries for v1 and none for v2:

```bash
export V1_POD=$(kubectl get pod -l app=httpbin,version=v1 -o jsonpath={.items..metadata.name})
kubectl logs "$V1_POD" -c httpbin
# [2024-02-09 11:13:52 +0000] [1] [INFO] Starting gunicorn 19.9.0
# [2024-02-09 11:13:52 +0000] [1] [INFO] Listening at: http://0.0.0.0:80 (1)
# [2024-02-09 11:13:52 +0000] [1] [INFO] Using worker: sync
# [2024-02-09 11:13:52 +0000] [9] [INFO] Booting worker with pid: 9
# 127.0.0.6 - - [09/Feb/2024:11:27:44 +0000] "GET /headers HTTP/1.1" 200 524 "-" "curl/8.6.0"
```

```bash
export V2_POD=$(kubectl get pod -l app=httpbin,version=v2 -o jsonpath={.items..metadata.name})
kubectl logs "$V2_POD" -c httpbin
# <none>
```

## [Mirroring traffic to v2](https://istio.io/latest/docs/tasks/traffic-management/mirroring/#mirroring-traffic-to-v2)

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
    - httpbin
  http:
  - route:
    - destination:
        host: httpbin
        subset: v1
      weight: 100
    mirror:
      host: httpbin
      subset: v2
    mirrorPercentage:
      value: 100.0
EOF
```

This route rule sends 100% of the traffic to v1. The last stanza specifies that you want to mirror (i.e., also send) 100% of the same traffic to the httpbin:v2 service. When traffic gets mirrored, the requests are sent to the mirrored service with their Host/Authority headers appended with -shadow. For example, cluster-1 becomes cluster-1-shadow.

Also, it is important to note that these requests are mirrored as “fire and forget”, which means that the responses are discarded.

You can use the value field under the mirrorPercentage field to mirror a fraction of the traffic, instead of mirroring all requests. If this field is absent, all traffic will be mirrored.

Send in traffic:

```bash
kubectl exec "${SLEEP_POD}" -c sleep -- curl -sS http://httpbin:8000/headers
```

Now, you should see access logging for both v1 and v2. The access logs created in v2 are the mirrored requests that are actually going to v1.

```bash
kubectl logs "$V1_POD" -c httpbin
# 127.0.0.6 - - [09/Feb/2024:11:27:44 +0000] "GET /headers HTTP/1.1" 200 524 "-" "curl/8.6.0"
# 127.0.0.6 - - [09/Feb/2024:11:31:25 +0000] "GET /headers HTTP/1.1" 200 524 "-" "curl/8.6.0"
```

```bash
kubectl logs "$V2_POD" -c httpbin
# 127.0.0.6 - - [09/Feb/2024:11:31:25 +0000] "GET /headers HTTP/1.1" 200 564 "-" "curl/8.6.0"
```

## [Cleanup](https://istio.io/latest/docs/tasks/traffic-management/mirroring/#cleaning-up)

```bash
kubectl delete virtualservice httpbin
kubectl delete destinationrule httpbin

kubectl delete deploy httpbin-v1 httpbin-v2 sleep
kubectl delete svc httpbin
```
