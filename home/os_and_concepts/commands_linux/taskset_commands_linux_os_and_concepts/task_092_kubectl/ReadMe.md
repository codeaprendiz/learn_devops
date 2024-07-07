# kubectl

## Examples

- To get all resource types from all namespaces

```bash
kubectl get all --all-namespaces
kubectl  get ep
```

- The `cluster-info` outputs a lot of JSON formatted cluster information. The grep -m 1 cluster-cidr part of the command filters the 
  output and returns the first line that contains the string cluster-cidr. This should be the network range used for the IP addresses 
  within the Kubernetes cluster

```bash
$ kubectl cluster-info dump | grep -m 1 cluster-cidr
                                    "kube-proxy --cluster-cidr=10.108.0.0/14 ......"
$ kubectl cluster-info dump | grep -m 1 "podCIDR"            
                "podCIDR": "10.108.1.0/24",

# You can also get podCIDR using
$ kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}'   # Will give podCIDR for every node
.
# Get service-cluster-ip-range
$ kubectl cluster-info dump | grep -m 1 service-cluster-ip-range
.
```

- This command is used to test DNS resolution within a Kubernetes cluster. 
  This command runs a pod in Kubernetes using the busybox image, and executes the nslookup command for kubernetes.default in that pod. 
  nslookup is a tool for querying the Domain Name System (DNS) to obtain domain name or IP address mapping or other DNS records.

```bash
$ kubectl run busybox --rm --image=busybox:1.28 --restart=Never -it -- nslookup kubernetes.default
Server:    10.112.0.10
Address 1: 10.112.0.10 kube-dns.kube-system.svc.cluster.local

Name:      kubernetes.default
Address 1: 10.112.0.1 kubernetes.default.svc.cluster.local
pod "busybox" deleted
```

- Start ubuntu container from custom nexus proxy which does not need password to pull image

```bash
$ kubectl run ubuntu --image=<IP_OF_NEXUS>:<EXPOSED_PORT>/ubuntu:latest --restart=Always -it -- bash
.
```

- To get all the available contexts

```bash
$ kubectl config get-contexts
.
```

- To rename the current set context

```bash
$ kubectl config rename-context <current-context-name> <new-name-of-the-context>
.
```

- To create kubernetes secret from env_file

```bash
kubectl create secret generic <name_of_secret> \
--from-env-file=secret.properties \
--dry-run=client -o yaml -n <namespace>

## Secret.properties file
ENV1=valueone
ENV2=data source=something, user=something; options=something
```

- To copy file from pod to local [stackoverflow](https://stackoverflow.com/questions/67624630/unable-to-copy-data-from-pod-to-local-using-kubectl-cp-command)

```bash
# kubectl cp <namespace>/<pod-name>:<path-in-pod> <local-path>
$ kubectl cp --retries=-1 mynamespace/mypod:/etc/config/config.txt ~/mylocaldir/
```


## json path

[kubectl/jsonpath/](https://kubernetes.io/docs/reference/kubectl/jsonpath/)

- Suppose we deploy sample nginx pod

```bash
$ kubectl get pods        
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          11m
```

- Get the full json object

```bash
$ kubectl get pods -o json
.
```

- Get the type of object

```bash
$ kubectl get pods -o=jsonpath='{$.kind}'
List
```

- Get the name of the pod

```bash
$ kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
nginx
```

- Get the nodeName

```bash
$ kubectl get pods -o=jsonpath='{.items[0].spec.nodeName}'
docker-desktop
```

- Get the container details 

```bash
$ kubectl get pods -o=jsonpath='{.items[0].spec.containers}'
[{"image":"nginx","imagePullPolicy":"Always","name":"nginx","resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/var/run/secrets/kubernetes.io/serviceaccount","name":"default-token-qg6zs","readOnly":true}]}]
```

- Get the deployed image name

```bash
$ kubectl get pods -o=jsonpath='{.items[0].spec.containers[0].image}'
nginx
```

- Get the pod IPs in pretty format

```bash
$ kubectl get pods -o=jsonpath='{.items[0].status.podIPs}' | jq
[
  {
    "ip": "10.1.5.59"
  }
]
```

- Get the phase of the pod

```bash
$ kubectl get pods -o=jsonpath='{.items[0].status.phase}'
Running
```

- Get the restart count of the first container

```bash
$ kubectl get pods -o=jsonpath='{.items[0].status.containerStatuses}' | jq

[
  {
    "containerID": "docker://55704ca318bc577589652a8851deac7fafa0b99b1d10a4527777bf816d5c5041",
    "image": "nginx:latest",
    "imageID": "docker-pullable://nginx@sha256:f3693fe50d5b1df1ecd315d54813a77afd56b0245a404055a946574deb6b34fc",
    "lastState": {},
    "name": "nginx",
    "ready": true,
    "restartCount": 0,
    "started": true,
    "state": {
      "running": {
        "startedAt": "2021-03-03T12:44:39Z"
      }
    }
  }
]

$ kubectl get pods -o=jsonpath='{.items[0].status.containerStatuses[0].restartCount}' | jq
0
```

- To get the list of pv's sorted by capacity storage

```bash
controlplane $ kubectl get pv --sort-by='{.spec.capacity.storage}'
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-log-4   40Mi       RWX            Retain           Available                                   5m39s
pv-log-1   100Mi      RWX            Retain           Available                                   5m39s
pv-log-2   200Mi      RWX            Retain           Available                                   5m39s
pv-log-3   300Mi      RWX            Retain           Available                                   5m39s
```