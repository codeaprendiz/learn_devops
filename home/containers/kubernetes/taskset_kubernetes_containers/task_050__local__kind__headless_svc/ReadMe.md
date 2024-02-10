# Headless SVC

- [kubernetes.io » Service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)

In Kubernetes, a headless service is a type of service that doesn't have a cluster IP and is used to directly access the pods. It's useful in scenarios where you don't need load-balancing and want to directly reach the individual pods, often used in stateful applications like databases.

- Create cluster

```bash
kind create cluster
```

- Apply

```bash
 kubectl apply -f .
```

- Get pods

```bash
kubectl get pods       
```

- Exec into `nginx-pod-1`

```bash
kubectl exec nginx-pod-1 -it -- bash
```

- Update

```bash
apt update
```

- Install `dnsutils`

```bash
apt-get install dnsutils
```

- Note the output

```bash
root@nginx-pod-1:/# nslookup nginx-headless
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   nginx-headless.default.svc.cluster.local
Address: 10.244.0.5
Name:   nginx-headless.default.svc.cluster.local
Address: 10.244.0.6
Name:   nginx-headless.default.svc.cluster.local
Address: 10.244.0.7
```

- You can also get the IPs o the pods which should be the same

```bash
$ kubectl get pods -o wide

NAME          READY   STATUS    RESTARTS   AGE     IP           NODE                 NOMINATED NODE   READINESS GATES
nginx-pod-1   1/1     Running   0          3m20s   10.244.0.5   kind-control-plane   <none>           <none>
nginx-pod-2   1/1     Running   0          3m20s   10.244.0.7   kind-control-plane   <none>           <none>
nginx-pod-3   1/1     Running   0          3m20s   10.244.0.6   kind-control-plane   <none>           <none>
```
