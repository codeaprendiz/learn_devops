# Practice Tasks

[task-000       :    Commands](practice-tasks/task-000-commands/commands.md)


Tasks Local |
---    | 
[task-local-001 :    Configure default cpu requests and limits for a namespace](practice-tasks/task-local-001-configure-default-CPU-requests-and-limits-for-a-namespace) |
[task-local-002 :    Configure default memory requests and limits for a namespace](practice-tasks/task-local-002-configure-default-memory-requests-and-limits-for-a-namespace)
[task-local-003 :    Understanding k8s port forward](practice-tasks/task-local-003-understanding-k8s-port-forward)
[task-local-004 :    Expose svc via nodeport](practice-tasks/task-local-004-expose-svc-via-nodeport)
[task-local-005 :    Access svc nodeport via ingress](practice-tasks/task-local-005-access-svc-nodeport-via-ingress)
[task-local-006 :    Access svc clusterip via ingress](practice-tasks/task-local-006-access-svc-clusterip-via-ingress)
[task-local-007 :    Jenkins k8s](practice-tasks/task-local-007-jenkins-k8s)
[task-local-008 :    Kafka](practice-tasks/task-local-008-kafka)
[task-local-009 :    Kafdrop](practice-tasks/task-local-009-kafdrop)
[task-aws-010   :    Deploy-treafik-kops-k8s-helm](practice-tasks/task-aws-010-deploy-treafik-kops-k8s-helm) |
[task-aws-011   :    Treafik-kops-whoami](practice-tasks/task-aws-011-treafik-kops-whoami)
[task-aws-012   :    Kops-with-treafik-customization](practice-tasks/task-aws-012-kops-with-treafik-customization)
[task-aws-013   :    Oauth2 proxy](practice-tasks/task-aws-013-oauth2-proxy)
[task-aws-014   :    Traefik kops whoami middleware](practice-tasks/task-aws-014-traefik-kops-whoami-middleware)
[task-aws-015   :    INPROGRESS lets encrypt kops cluster](practice-tasks/task-aws-015-lets-encrypt-kops-cluster)
[task-aws-016   :    k8s cluster using kops](practice-tasks/task-aws-016-k8s-cluster-using-kops)
[task-aws-017   :    Updating a kops cluster](practice-tasks/task-aws-017-updating-a-kops-cluster)
[task-aws-018   :    Kong ingress on eks](practice-tasks/task-aws-018-kong-ingress-on-eks)
[task-gcp-019   :    Elastic search](practice-tasks/task-gcp-019-elastic-search)
[task-gcp-020   :    Basic namespace wide kubeconfig](practice-tasks/task-gcp-020-basic-namespace-wide-kubeconfig)
[task-gcp-021   :    Intermediate namespace wide kubeconfig](practice-tasks/task-gcp-021-intermediate-namespace-wide-kubeconfig)
[task-gcp-022   :    k8s dashboard](practice-tasks/task-gcp-022-k8s-dashboard)


## gcp

### Learning Tasks



Domain | Tasks | 
---    | --- | 
Initial Steps | [commands](task-000-commands/commands.md) <br> [basics](task-000-commands/basics.md) <br> [docs links](task-000-commands/doclinks.md) |
External IP | [external IP to access Application In Cluster](gcp/task-008-external-IP-to-access-Application-In-Cluster) |
DNS and Static IPs | [configuring dns with static IPs k8 using-Service](gcp/task-009-configuring-dns-with-static-IPs-k8-using-Service) <br> [configuring dns with static IPs k8 using Ingress](gcp/task-010-configuring-dns-with-static-IPs-k8-using-Ingress) |
Administer A Cluster | [Configure default CPU requests and limits for a namespace](local-mac/task-001-configure-default-CPU-requests-and-limits-for-a-namespace) <br>  [Configure default memory requests and limits for a namespace](./local-mac/task-002-configure-default-memory-requests-and-limits-for-a-namespace) | 
Understanding kubectl port-forward | [Understand kubectl port forward](local-mac/task-003-understanding-k8s-port-forward)
Expose Service via NodePort | [Expose Service Via NodePort](local-mac/task-004-expose-svc-via-nodeport)
Expose Service via NodePort and Ingress | [Expose Service via NodePort and Ingress](local-mac/task-005-access-svc-nodeport-via-ingress)
Expose Service via ClusterIp and Ingress | [Expose Service via ClusterIP and Ingress](local-mac/task-006-access-svc-clusterip-via-ingress)
TLS KOPS k8s Let's Encrypt | [IN-PROGRESS - Create k8s using kops, enable https using let's encrypt for given domain and deploy whoami on the same](aws/task-019-lets-encrypt-kops-cluster) | 
Create Kops cluster | [Creating a kops cluster](aws/task-028-k8s-cluster-using-kops)
Updating a Kops cluster | [Updating existing KOPS cluster resources](aws/task-029-updating-a-kops-cluster)
Deploying traefik using Helm Kops | [Deploy traefik using Helm in Kops](aws/task-001-deploy-treafik-kops-k8s-helm)
Deploying traefik on KOPS with whoami | [Deploying traefik on KOPS with whoami](aws/task-002-treafik-kops-whoami)
Understanding Middlewares in Treafik KOPS whoami | [Traefik Middleware Kops whoami](aws/task-003-traefik-kops-whoami-middleware)
Deploying jenkins on kubernetes | [Deploying jenkins on kubernetes](local-mac/task-007-jenkins-k8s)
Dashboard | [k8s-dashboard](gcp/task-001-k8s-dashboard/)|
RBAC |  [basic namespace wide kubeconfig](gcp/task-002-basic-namespace-wide-kubeconfig) <br> [intermediate namespace wide kubeconfig](gcp/task-003-intermediate-namespace-wide-kubeconfig)  <br>  [intermediate cluster wide kubeconfig](gcp/task-004-intermediate-cluster-wide-kubeconfig) |
Traefik | [whoami](gcp/task-005-traefik-whoami) <br>  [whoami toml In ConfigMap](gcp/task-006-traefik-whoami-tomlInConfigMap) <br> [whoami lets encrypt](gcp/task-007-traefik-whoami-lets-encrypt) <br> [whoami tls custom-certs](gcp/task-013-traefik-whoami-tls-custom-certs)| 
Monitoring | [configuring datadog](gcp/task-011-configuring-datadog) <br> [configuring metricbeat](gcp/task-014-metricbeat) <br> [kube-state-metrics](gcp/task-015-kube-state-metrics) | 
Logging | [journalbeat](gcp/task-016-journalbeat)  |
EKS Kong | [Configuring Kong on EKS cluster and doing some basic tasks to learn its functionality](aws/task-030-kong-ingress-on-eks) |
Kafka On local Using Helm | [Installing Kafka on local using helm](local-mac/task-008-kafka)
Kafdrop for kafka monitoring | [Kafdrop for kafka monitoring](local-mac/task-009-kafdrop)
Kafdrop on kops authenticated by Oauth2-proxy | [Kafdrop OAuth2-proxy kops traefik](aws/task-004-oauth2-proxy)
Traefik Custom Changes in Image for X-trace-id with kops | [Kops Custom Traefik with X-Trace-ID for every request](aws/task-005-kops-with-treafik-customization)

Domain | Tasks | 
---    | --- | 
Blue Green Deployment | [Blue Green Deployment](concepts/task-001-blue-green-deployment) |
Networking in Kubernetes | [Networking in kubernetes](concepts/task-002-networking)



