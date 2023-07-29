# Kind Cluster

## Validate Persistent Volume Set Up using [ExtraMounts](https://kind.sigs.k8s.io/docs/user/configuration/#extra-mounts)

Extra mounts can be used to pass through storage on the host to a kind node for persisting data, mounting through code etc.

```bash
mkdir /tmp/kindpath

```

- config.yaml

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  # add a mount from /path/to/my/files on the host to /files on the node
  extraMounts:
  - hostPath: /tmp/kindpath
    containerPath: /files   
```

- Create Cluster

```bash
kind create cluster --config - <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  # add a mount from /path/to/my/files on the host to /files on the node
  extraMounts:
  - hostPath: /tmp/kindpath
    containerPath: /files
EOF
```

- pv.yaml : To create a persistent volume

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/tmp/kindpath"
```

- pvc.yaml : To create persistent volume claim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

- pod.yaml : To create a pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: local-pod
spec:
  containers:
  - name: local-container
    image: nginx
    volumeMounts:
    - name: local-volume
      mountPath: "/mnt/data"
  volumes:
  - name: local-volume
    persistentVolumeClaim:
      claimName: local-pvc
```

- Apply

```bash
$ kubectl apply -f pv.yaml,pvc.yaml,pod.yaml                 
persistentvolume/local-pv created
persistentvolumeclaim/local-pvc created
pod/local-pod created
```

- Validate

```bash
kubectl exec -it local-pod -- bash
root@local-pod:/# cd /mnt/data
root@local-pod:/mnt/data# ls
root@local-pod:/mnt/data# echo "hello" > test.log
root@local-pod:/mnt/data# cat test.log 
hello
root@local-pod:/mnt/data# exit
exit

## get and delete
$ kubectl get pods                  
NAME        READY   STATUS    RESTARTS   AGE
local-pod   1/1     Running   0          2m27s

$ kubectl delete pod local-pod
pod "local-pod" deleted

# Create again
$ kubectl apply -f dep.yaml                 
pod/local-pod created

# login to pod and check if file exists
kubectl exec -it local-pod -- bash
root@local-pod:/# cd /mnt/data
root@local-pod:/mnt/data# cat test.log 
hello
```

## Extra Port Mapping

[extra-port-mappings](https://kind.sigs.k8s.io/docs/user/configuration/#extra-port-mappings)

- config.yaml

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  # port forward 80 on the host to 80 on this node
  extraPortMappings:
  - containerPort: 8080
    hostPort: 8080
    # optional: set the bind address on the host
    # 0.0.0.0 is the current default
    listenAddress: "127.0.0.1"
    # optional: set the protocol to one of TCP, UDP, SCTP.
    # TCP is the default
    protocol: TCP
```

- Create

```bash
kind create cluster --config  config.yaml
```

- pod.yaml

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: foo
spec:
  containers:
  - name: foo
    image: nginx:latest
    ports:
    - containerPort: 80
      hostPort: 8080
```

- Apply

[Empty reply from server](https://github.com/kubernetes-sigs/kind/issues/1618)

```bash
kubectl apply -f pod.yaml
pod/foo created

# hit localhost:8080
curl --silent localhost:8080 | egrep "Welcome"
<title>Welcome to nginx!</title>
<h1>Welcome to nginx!</h1>
```

## [NodePort with Port Mappings](https://kind.sigs.k8s.io/docs/user/configuration/#nodeport-with-port-mappings)

To use port mappings with NodePort, the kind node containerPort and the service nodePort needs to be equal.

- config.yaml

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30951
    hostPort: 8080
```

- pod.yaml

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: foo
  labels:
    app: foo
spec:
  containers:
  - name: foo
    image: nginx:latest
    ports:
    - containerPort: 80
```

- svc.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: foo
spec:
  type: NodePort
  ports:
  - name: http
    nodePort: 30951
    port: 80
  selector:
    app: foo
```

- Apply

```bash
$ kubectl apply -f pod.yaml,svc.yaml
pod/foo created
service/foo created

$ kubectl get pods
NAME   READY   STATUS    RESTARTS   AGE
foo    1/1     Running   0          64m

# hit localhost:8080 and check
curl --silent localhost:8080 | egrep -i welcome
<title>Welcome to nginx!</title>
<h1>Welcome to nginx!</h1>
```

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

