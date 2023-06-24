
## Deploy ECK in your kubernetes cluster
[k8s-deploy-eck](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html#k8s-deploy-eck)

- Install custom resource definitions and the operator with its RBAC rules:
  
```bash
$ kubectl apply -f https://download.elastic.co/downloads/eck/1.0.1/all-in-one.yaml
customresourcedefinition.apiextensions.k8s.io/apmservers.apm.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/elasticsearches.elasticsearch.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/kibanas.kibana.k8s.elastic.co created
clusterrole.rbac.authorization.k8s.io/elastic-operator created
clusterrolebinding.rbac.authorization.k8s.io/elastic-operator created
namespace/elastic-system created
statefulset.apps/elastic-operator created
serviceaccount/elastic-operator created
validatingwebhookconfiguration.admissionregistration.k8s.io/elastic-webhook.k8s.elastic.co created
service/elastic-webhook-server created
secret/elastic-webhook-server-cert created
```

## Deploy an Elastic Search Cluster
[k8s-deploy-elasticsearch](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html#k8s-deploy-elasticsearch)

```bash
$ cat <<EOF | kubectl apply -f -
> apiVersion: elasticsearch.k8s.elastic.co/v1
> kind: Elasticsearch
> metadata:
>   name: quickstart
> spec:
>   version: 7.6.2
>   nodeSets:
>   - name: default
>     count: 1
>     config:
>       node.master: true
>       node.data: true
>       node.ingest: true
>       node.store.allow_mmap: false
> EOF
elasticsearch.elasticsearch.k8s.elastic.co/quickstart created
```