# Prometheus Operator

- [prometheus-operator.dev](https://prometheus-operator.dev/docs/prologue/quick-start)
- [prometheus-operator/kube-prometheus](https://github.com/prometheus-operator/kube-prometheus)

## Create a kind cluster

```bash
$ kind create cluster --config kind-config.yaml

$ kubectl get nodes                                           
NAME                 STATUS   ROLES           AGE     VERSION
kind-control-plane   Ready    control-plane   2m13s   v1.24.0

```

## Clone the repo

```bash
$ git clone https://github.com/prometheus-operator/kube-prometheus.git

$ ls
ReadMe.md        kind-config.yaml kube-prometheus

$ mv kube-prometheus/manifests .

$ ls
ReadMe.md        kind-config.yaml kube-prometheus  manifests

$ rm -rf kube-prometheus 
```

## Deploy kube-prometheus 

```bash
$ kubectl create -f manifests/setup

## Wait till you see following is met
$ kubectl wait \
        --for condition=Established \
        --all CustomResourceDefinition \
        --namespace=monitoring

$ kubectl apply -f manifests/


$ kubectl get pods -n monitoring   
NAME                                   READY   STATUS    RESTARTS        AGE
alertmanager-main-0                    2/2     Running   1 (2m27s ago)   6m21s
alertmanager-main-1                    2/2     Running   1 (2m25s ago)   6m21s
alertmanager-main-2                    2/2     Running   1 (2m26s ago)   6m21s
blackbox-exporter-58c9c5ff8d-c4g9j     3/3     Running   0               8m55s
grafana-6b4547d9b8-lnz67               1/1     Running   0               8m54s
kube-state-metrics-6d454b6f84-vxnnn    3/3     Running   0               8m54s
node-exporter-px95k                    2/2     Running   0               8m54s
prometheus-adapter-678b454b8b-7vf55    1/1     Running   0               8m54s
prometheus-adapter-678b454b8b-tp8jn    1/1     Running   0               8m54s
prometheus-k8s-0                       2/2     Running   0               6m21s
prometheus-k8s-1                       2/2     Running   0               6m21s
```

## Access Prometheus

```bash
 kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090
Forwarding from 127.0.0.1:9090 -> 9090
Forwarding from [::1]:9090 -> 9090
```

- Now visit [localhost:9090](localhost:9090)

![img.png](.images/promethues.png)

![img.png](.images/promethues-alerts.png)

## Access Alertmanager

```bash
kubectl --namespace monitoring port-forward svc/alertmanager-main 9093
Forwarding from 127.0.0.1:9093 -> 9093
Forwarding from [::1]:9093 -> 9093

```

- Now visit [localhost:9093](localhost:9093)

![img.png](.images/alertmanager.png)


## Access Grafana 

```bash
$ kubectl --namespace monitoring port-forward svc/grafana 3000
Forwarding from 127.0.0.1:3000 -> 3000
Forwarding from [::1]:3000 -> 3000
```

- Now visit [localhost:3000](localhost:3000)
- use `admin` as username and `admin` as password

![img.png](.images/grafana.png)

![img.png](.images/kubernetes-compute-resources-namespace-pods.png)

You can check out the other dashboards as well


- Clean up

```bash
$ kind delete cluster

rm -rf manifests
```