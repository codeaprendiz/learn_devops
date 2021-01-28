Referenced Docs
1) https://www.datadoghq.com/blog/monitoring-kubernetes-with-datadog/



- Secret resource Created
```bash
kubectl create secret generic datadog-secret --from-literal api-key="2dd8*******************74d48f"
```

- Run the following commands
```bash
kubectl apply -f .
```

- Verification of agent and ensure that
    - all status's are OK
    - API key is valid
    - logs are getting shipped
```bash
$ kubectl exec -it datadog-agent-rp2bs agent status | egrep "OK|API Key valid|FAIL|API Key invalid"
      Instance ID: cpu [OK]
      Instance ID: disk:e5dffb8bef24336f [OK]
      Instance ID: docker [OK]
      Instance ID: file_handle [OK]
      Instance ID: io [OK]
      Instance ID: kube_dns:cd40e8b0b9591c53 [OK]
      Instance ID: kubelet:d884b5186b651429 [OK]
      Instance ID: kubernetes_apiserver [OK]
      Instance ID: kubernetes_state:786c62219a8c6f42 [OK]
      Instance ID: load [OK]
      Instance ID: memory [OK]
      Instance ID: network:e0204ad63d43c949 [OK]
      Instance ID: ntp:d884b5186b651429 [OK]
      Instance ID: prometheus:datadog.cluster_agent:c45da342a409d029 [OK]
      Instance ID: uptime [OK]
    API key ending with 4d48f: API Key valid
    Status: OK
    Status: OK
```


- Deploy the cluster agent
```bash
kubectl get pods -l app=datadog-cluster-agent
```

- Check the status of cluster-agent
```bash
$ kubectl exec -it datadog-cluster-agent-67588d6f7b-znkxm agent status | egrep "OK|API Key valid"
      Instance ID: kubernetes_apiserver [OK]
    API key ending with 4d48f: API Key valid
```


- Now login to datadog and let's see what we have achieved so far

### Logs 

- Live Tail

![](../../../images/kubernetes/gcp/task-011-configuring-datadog/live-tail-logs.png)


- Logs dashboard

![](../../../images/kubernetes/gcp/task-011-configuring-datadog/logs-dasboard-page.png)


### Dashboard

- k8s dashboard

![](../../../images/kubernetes/gcp/task-011-configuring-datadog/k8s-dashboard-pic1.png)


![](../../../images/kubernetes/gcp/task-011-configuring-datadog/k8s-dashboard-pic2.png)


![](../../../images/kubernetes/gcp/task-011-configuring-datadog/k8s-dashboard-pic3.png)

### Events

- Events tab

![](../../../images/kubernetes/gcp/task-011-configuring-datadog/events-tab.png)
