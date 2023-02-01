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
