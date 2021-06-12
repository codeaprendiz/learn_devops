# kubernetes-kitchen



## gcp

### Learning Tasks



Domain | Tasks | 
---    | --- | 
Initial Steps | [commands](task-000-commands/commands.md) <br> [basics](task-000-commands/basics.md) <br> [docs links](task-000-commands/doclinks.md) |
External IP | [external IP to access Application In Cluster](gcp/task-008-external-IP-to-access-Application-In-Cluster) |
DNS and Static IPs | [configuring dns with static IPs k8 using-Service](gcp/task-009-configuring-dns-with-static-IPs-k8-using-Service) <br> [configuring dns with static IPs k8 using Ingress](gcp/task-010-configuring-dns-with-static-IPs-k8-using-Ingress) |
Administer A Cluster | [Configure default CPU requests and limits for a namespace](local-mac/administer-a-cluster/task-017-configure-default-CPU-requests-and-limits-for-a-namespace) <br>  [Configure default memory requests and limits for a namespace](./local-mac/administer-a-cluster/task-018-configure-default-memory-requests-and-limits-for-a-namespace) | 
TLS KOPS k8s Let's Encrypt | [IN-PROGRESS - Create k8s using kops, enable https using let's encrypt for given domain and deploy whoami on the same](aws/task-019-lets-encrypt-kops-cluster) | 
Create Kops cluster | [Creating a kops cluster](aws/task-028-k8s-cluster-using-kops)
Updating a Kops cluster | [Updating existing KOPS cluster resources](aws/task-029-updating-a-kops-cluster)
Deploying traefik using Helm Kops | [Deploy traefik using Helm in Kops](aws/task-001-deploy-treafik-kops-k8s-helm)
Deploying traefik on KOPS with whoami | [Deploying traefik on KOPS with whoami](aws/task-002-treafik-kops-whoami)
Understanding Middlewares in Treafik KOPS whoami | [Traefik Middleware Kops whoami](aws/task-003-traefik-kops-whoami-middleware)

### Enterprise Level Tasks



Domain | Tasks | 
---    | --- | 
Dashboard | [k8s-dashboard](gcp/task-001-k8s-dashboard/)|
RBAC |  [basic namespace wide kubeconfig](gcp/task-002-basic-namespace-wide-kubeconfig) <br> [intermediate namespace wide kubeconfig](gcp/task-003-intermediate-namespace-wide-kubeconfig)  <br>  [intermediate cluster wide kubeconfig](gcp/task-004-intermediate-cluster-wide-kubeconfig) |
Traefik | [whoami](gcp/task-005-traefik-whoami) <br>  [whoami toml In ConfigMap](gcp/task-006-traefik-whoami-tomlInConfigMap) <br> [whoami lets encrypt](gcp/task-007-traefik-whoami-lets-encrypt) <br> [whoami tls custom-certs](gcp/task-013-traefik-whoami-tls-custom-certs)| 
Monitoring | [configuring datadog](gcp/task-011-configuring-datadog) <br> [configuring metricbeat](gcp/task-014-metricbeat) <br> [kube-state-metrics](gcp/task-015-kube-state-metrics) | 
Logging | [journalbeat](gcp/task-016-journalbeat)  |





