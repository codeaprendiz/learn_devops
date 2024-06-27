# Learning Kind Cluster

<br>

## Extra Port Mapping

[extra-port-mappings](https://kind.sigs.k8s.io/docs/user/configuration/#extra-port-mappings)

Extra port mappings can be used to port forward to the kind nodes. This is a cross-platform option to get traffic into your kind cluster.

If you are running Docker without the Docker Desktop Application on Linux, you can simply send traffic to the node IPs from the host without extra port mappings. With the installation of the Docker Desktop Application, whether it is on macOs, Windows or Linux, you’ll want to use these.

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
