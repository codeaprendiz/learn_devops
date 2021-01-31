
### Configure Default CPU Requests and Limits for a Namespace

[administer-cluster/manage-resources/cpu-default-namespace/](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/)

- Create a namespace

```bash
$ kubectl create namespace default-cpu-example
namespace/default-cpu-example created
```


- Create a LimitRange object

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
spec:
  limits:
    - default:
        cpu: 1
      defaultRequest:
        cpu: 0.5
      type: Container
```

- create pod nginx with no limit on CPU

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-cpu-demo
spec:
  containers:
  - name: default-cpu-demo-ctr
    image: nginx
```

- Apply the changes

```bash
$ kubectl apply -f . --namespace=default-cpu-example
limitrange/cpu-limit-range created
pod/default-cpu-demo created
```

- Check the changes

```bash
$ kubectl get pod default-cpu-demo --output=yaml --namespace=default-cpu-example | egrep -i "resources:" -A 4 | egrep -v "f:|{|-"
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: 500m
```

The output shows that the Pod's Container has a CPU request of 500 millicpus and a CPU limit of 1 cpu. These are the default values specified by the LimitRange.


**What if you specify a Container's limit, but not its request?**


```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-cpu-demo-2
spec:
  containers:
    - name: default-cpu-demo-2-ctr
      image: nginx
      resources:
        limits:
          cpu: "1"
```

- Apply the changes

```bash
$ kubectl apply -f . --namespace=default-cpu-example                                                                             
limitrange/cpu-limit-range configured
pod/default-cpu-demo-2 created
pod/default-cpu-demo unchanged
```

- Check the changes

```bash
$ kubectl get pod default-cpu-demo-2 --output=yaml --namespace=default-cpu-example | egrep -i "resources:" -A 4 | egrep -v "f:|{|-"
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: "1"
```

The output shows that the Container's CPU request is set to match its CPU limit. Notice that the Container was not assigned the default CPU request value of 0.5 cpu.


**What if you specify a Container's request, but not its limit?**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-cpu-demo-3
spec:
  containers:
  - name: default-cpu-demo-3-ctr
    image: nginx
    resources:
      requests:
        cpu: "0.75"
```

- Apply the changes

```bash
$ kubectl apply -f . --namespace=default-cpu-example                                                                               
limitrange/cpu-limit-range configured
pod/default-cpu-demo-2 unchanged
pod/default-cpu-demo unchanged
pod/default-cpu-demo-3 created
```

- Check the changes

```bash
$ kubectl get pod default-cpu-demo-3 --output=yaml --namespace=default-cpu-example | egrep -i "resources:" -A 4 | egrep -v "f:|{|-"
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: 750m
```


- Delete the resources

```bash
$ kubectl delete -f . --namespace=default-cpu-example                                                                              
limitrange "cpu-limit-range" deleted
pod "default-cpu-demo-2" deleted
pod "default-cpu-demo" deleted
pod "default-cpu-demo-3" deleted
```