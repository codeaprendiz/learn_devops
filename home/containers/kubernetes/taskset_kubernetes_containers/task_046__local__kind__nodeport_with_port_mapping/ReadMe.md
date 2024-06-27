# Learn Kind Cluster

<br>

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
