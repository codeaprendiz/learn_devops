# Kind Cluster

## Validate Persistent Volume Set Up

[kind.sigs.k8s.io/docs/user/configuration](https://kind.sigs.k8s.io/docs/user/configuration/)

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
kind create cluster --config  config.yaml
```

- pv.yaml

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

- pvc.yaml

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

- dep.yaml

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
$ kubectl apply -f pv.yaml,pvc.yaml,dep.yaml                 
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

- Dep.yaml

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

```bash
kubectl apply -f dep.yaml
pod/foo created

# hit localhost:8080
curl --silent localhost:8080 | egrep "Welcome"
<title>Welcome to nginx!</title>
<h1>Welcome to nginx!</h1>
```

## NodePort with Port Mappings

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

