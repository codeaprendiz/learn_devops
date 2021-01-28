### To start metricbeat in kubernetes cluster and ship the kubernetes metrics to elastic search which can be viewed by kibana


#### Pre-requisites

- elastic-search-docker: 
    - You can install elastic-search docker by visiting [elastic-search-docker](https://github.com/codeaprendiz/ansible-kitchen/tree/master/playbooks/roles/elastic-search-cluster-docker) and 
- kibana-docker: 
    - You can install kibana docker by using this link [kibana-docker](https://github.com/codeaprendiz/ansible-kitchen/tree/master/playbooks/roles/kibana-docker)
- kube-state-metrics:
    - You need to install kube-state-metrics as this will be used by metric beat to featch additional metrics. You can 
      do so by using this task-link [task-015-kube-state-metrics](../task-015-kube-state-metrics)

- Docs referred

    - [k8s resources](https://raw.githubusercontent.com/elastic/beats/7.8/deploy/kubernetes/metricbeat-kubernetes.yaml)

    - [metricbeat](https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-reference-yml.html)

- Change the IPs of elastic-search `20-daemonset.yaml` and `24-deployment.yaml` with the public IP which you get.

- Change the IP of kibana in `16-configmap-metricbeat-daemonset.yaml` with the public IP of kibana which you get.

- Apply the k8s resources 
```bash
$ kubectl apply -f .

```

- Metricbeat logs after successful connection to elastic search

```bash
2020-07-31T10:18:29.404Z        INFO    [publisher_pipeline_output]     pipeline/output.go:144  Connecting to backoff(elasticsearch(http://35.226.68.74:9200))
2020-07-31T10:18:34.475Z        INFO    [publisher_pipeline_output]     pipeline/output.go:152  Connection to backoff(elasticsearch(http://35.226.68.74:9200)) established
```

- Now you can check you infrastructure in kibana as showing in the following screenshot (Observability - metrics)

    - Infra VMs

        ![](../../../images/kubernetes/gcp/task-014-metricbeat/Infra-vms.png)

    - Infra Pods
    
        ![](../../../images/kubernetes/gcp/task-014-metricbeat/Infra-Pods.png)
        
    - Pod Metrics
    
        ![](../../../images/kubernetes/gcp/task-014-metricbeat/Pod-metrics.png)
        
    - Pre Built Imported Dashboard
    
        ![](../../../images/kubernetes/gcp/task-014-metricbeat/K8s-dashboard.png)
        
    - Pre Built System - Overview Dashboard
    
        ![](../../../images/kubernetes/gcp/task-014-metricbeat/system-overview.png)
        
    - Pre Built Host Overview Dashboard
    
        ![](../../../images/kubernetes/gcp/task-014-metricbeat/host-overview.png)
        
        ![](../../../images/kubernetes/gcp/task-014-metricbeat/host-overview-2.png)
        
    - Pre Built Containers Dashboard
    
        ![](../../../images/kubernetes/gcp/task-014-metricbeat/containers-overview.png)
     
        
        

    
    


