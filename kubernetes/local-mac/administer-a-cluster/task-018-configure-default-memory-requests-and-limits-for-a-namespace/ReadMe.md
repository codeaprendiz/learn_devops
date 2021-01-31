
### Configure Default Memory Requests and Limits for a Namespace

[administer-cluster/manage-resources/memory-default-namespace/](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/)

- create the namespace

```bash
$ kubectl create namespace default-mem-example

namespace/default-mem-example created
```

- Create limit range object

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
    - default:
        memory: 512Mi
      defaultRequest:
        memory: 256Mi
      type: Container
```

```bash
$ kubectl apply -f . --namespace=default-mem-example
limitrange/mem-limit-range created
```

- Create a pod without specifying a memory request and limit.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-mem-demo
spec:
  containers:
    - name: default-mem-demo-ctr
      image: nginx
```

```bash
$ kubectl apply -f . --namespace=default-mem-example
pod/default-mem-demo created
limitrange/mem-limit-range unchanged
```

- Now check the memory stats of the pod created. Both are as per defaults

```bash
$ kubectl get pod default-mem-demo -o yaml --namespace=default-mem-example | egrep -i "resources:" -A 4 | egrep -v "f:"
--
    resources:
      limits:
        memory: 512Mi
      requests:
        memory: 256Mi
```



**What if you specify a Container's limit, but not its request?**

- Create the pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-mem-demo-2
spec:
  containers:
    - name: default-mem-demo-2-ctr
      image: nginx
      resources:
        limits:
          memory: "1Gi"
```

```bash
$ kubectl apply -f . --namespace=default-mem-example
limitrange/mem-limit-range unchanged
pod/default-mem-demo-2 created
pod/default-mem-demo created
```

- check the stats.

```bash
$ kubectl get pod default-mem-demo-2 -o yaml --namespace=default-mem-example | egrep -i "resources:" -A 4 | egrep -v "f:|{|-"
    resources:
      limits:
        memory: 1Gi
      requests:
        memory: 1Gi
```

**What if you specify a Container's request, but not its limit?**

- Apply the changes

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-mem-demo-3
spec:
  containers:
    - name: default-mem-demo-3-ctr
      image: nginx
      resources:
        requests:
          memory: "128Mi"
```

```bash
$ kubectl apply -f . --namespace=default-mem-example                                                                         
limitrange/mem-limit-range unchanged
pod/default-mem-demo-2 unchanged
pod/default-mem-demo unchanged
pod/default-mem-demo-3 created
```

- check the changes

```bash
$ kubectl get pod default-mem-demo-3 -o yaml --namespace=default-mem-example | egrep -i "resources:" -A 4 | egrep -v "f:|{|-"
    resources:
      limits:
        memory: 512Mi
      requests:
        memory: 128Mi
```




- Remove the resources

```bash
$ kubectl delete -f . --namespace=default-mem-example                                                                        
limitrange "mem-limit-range" deleted
pod "default-mem-demo-2" deleted
pod "default-mem-demo" deleted
pod "default-mem-demo-3" deleted
```
