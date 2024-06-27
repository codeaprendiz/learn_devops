# Learn Kind Cluster

<br>

## Using Ingress

[ingress-nginx](https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx)

- config.yaml

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
```

- create cluster

```bash
$ kind create cluster --config  config.yaml
```

- apply following

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

- Are we ready ?

```bash

$ kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
error: timed out waiting for the condition on pods/ingress-nginx-controller-6bccc5966-tzr87

# try again
$ kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
pod/ingress-nginx-controller-6bccc5966-tzr87 condition met
```

- pod-foo-app.yaml


```yaml
kind: Pod
apiVersion: v1
metadata:
  name: foo-app
  labels:
    app: foo
spec:
  containers:
  - command:
    - /agnhost
    - netexec
    - --http-port
    - "8080"
    image: registry.k8s.io/e2e-test-images/agnhost:2.39
    name: foo-app

```

- svc-foo.yaml

```yaml
kind: Service
apiVersion: v1
metadata:
  name: foo-service
spec:
  selector:
    app: foo
  ports:
  # Default port used by the image
  - port: 8080
```

- pod-bar-app.yaml

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: bar-app
  labels:
    app: bar
spec:
  containers:
  - command:
    - /agnhost
    - netexec
    - --http-port
    - "8080"
    image: registry.k8s.io/e2e-test-images/agnhost:2.39
    name: bar-app
```

- svc-bar.yaml

```yaml
kind: Service
apiVersion: v1
metadata:
  name: bar-service
spec:
  selector:
    app: bar
  ports:
  # Default port used by the image
  - port: 8080
```

- ingress.yaml

```yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  rules:
  - http:
      paths:
      - pathType: Prefix
        path: /foo(/|$)(.*)
        backend:
          service:
            name: foo-service
            port:
              number: 8080
      - pathType: Prefix
        path: /bar(/|$)(.*)
        backend:
          service:
            name: bar-service
            port:
              number: 8080
---
```

- Apply

```yaml
kubectl apply -f .                                          
ingress.networking.k8s.io/example-ingress created
pod/bar-app created
pod/foo-app created
service/bar-service created
service/foo-service created

kubectl get pods       
NAME      READY   STATUS    RESTARTS   AGE
bar-app   1/1     Running   0          92s
foo-app   1/1     Running   0          92s
```

- Validate

```bash
curl localhost/foo/hostname
foo-app

curl localhost/bar/hostname
bar-app
```

