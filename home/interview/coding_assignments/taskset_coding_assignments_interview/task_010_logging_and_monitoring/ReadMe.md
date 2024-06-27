### We will set up monitoring using datadog

- Install the repo

```bash
$ helm repo add datadog https://helm.datadoghq.com 
"datadog" already exists with the same configuration, skipping
```

- Add stable repository

```bash
$ helm repo add stable https://charts.helm.sh/stable
"stable" already exists with the same configuration, skipping

```

- Helm repo update

```bash
$ helm repo update
```

- Download [values.yaml](https://github.com/DataDog/helm-charts/blob/main/charts/datadog/values.yaml)

- Install

```bash
$ helm install datadog-release -f values.yaml --set datadog.site='datadoghq.com' --set datadog.apiKey='43be5f5f323690b33cabe30f946d6a10' datadog/datadog
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /Users/ankitsinghrathi/Ankit/workspace/devops-essentials/terraform/aws/task-030-creating-eks/kubeconfig
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /Users/ankitsinghrathi/Ankit/workspace/devops-essentials/terraform/aws/task-030-creating-eks/kubeconfig
NAME: datadog-release
LAST DEPLOYED: Thu Aug 26 00:40:03 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Datadog agents are spinning up on each node in your cluster. After a few
minutes, you should see your agents starting in your event stream:
    https://app.datadoghq.com/event/stream



NAME                                                  READY   STATUS    RESTARTS   AGE
datadog-release-2w2pp                                 2/2     Running   0          59s
datadog-release-cluster-agent-6bc5df7bff-p7csx        1/1     Running   0          58s
datadog-release-h7rm4                                 2/2     Running   0          59s
datadog-release-kube-state-metrics-5955d8b769-2qxw8   1/1     Running   0          58s
datadog-release-zbkhv                                 2/2     Running   0          59s



$ kubectl exec -it datadog-release-m7fxb -- agent status | grep "OK"  
Defaulted container "agent" out of: agent, process-agent, init-volume (init), init-config (init)
      Instance ID: cpu [OK]
      Instance ID: disk:e5dffb8bef24336f [OK]
      Instance ID: docker [OK]
      Instance ID: file_handle [OK]
      Instance ID: io [OK]
      Instance ID: load [OK]
      Instance ID: memory [OK]
      Instance ID: network:d884b5186b651429 [OK]
      Instance ID: ntp:d884b5186b651429 [OK]
      Instance ID: uptime [OK]


```

- Deploy the rest of the services in EKS

```bash
$ kubectl apply -f dep.yaml,ingress.yaml,hpa.yaml
deployment.apps/nginx-dep created
ingress.networking.k8s.io/ingress-wildcard-host created
horizontalpodautoscaler.autoscaling/nginx-dep create
```

- Generate logs

```bash
$ kubectl port-forward nginx-dep-ff8db6854-gw7x6 8080:80
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
```


- Logs shipped to datadog

![](.images/logs-shipped.png)


- Kubernetes Overview

![](.images/kubernetes-overview.png)

![](.images/k8s-overview.png)

- Pods Overview

![](.images/pods-overview.png)


- Host map

![](.images/hostmap.png)

- Infrastructure list

![](.images/infra-list.png)

- Containers

![](.images/containers.png)

- CoreDNS Overview

![](.images/coredns-overview.png)

- Docker Overview

![](.images/docker-overview.png)

- Daemonset overview

![](.images/daemonset-overview.png)

- Deployments Overview

![](.images/deployments-overview.png)

![](.images/deployment-overview2.png)

- Cronjob Overview

![](.images/cronjob-overview.png)

- Nodes Overview

![](.images/nodes-overview.png)




<br>

### Alert Montor

This can also be integrated with slack

![](.images/alert.png)

We generate 500 logs manually

![](.images/generate500.png)

And Monitor gets triggered

![](.images/monitortriggered.png)