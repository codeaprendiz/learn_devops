### Create k8s cluster using kops

[production-environment/tools/kops](https://kubernetes.io/docs/setup/production-environment/tools/kops/)

[getting_started/install](https://kops.sigs.k8s.io/getting_started/install/)


#### Pre-requisite

You should own a domain for example in this case I own `devopsk8.com`

This should create a default hosted zone as well with Hosted-Zone-ID=XXXXXXXX

```bash
$ dig ns devopsk8.com | egrep "ANSWER SECTION" -A 4
;; ANSWER SECTION:
devopsk8.com.           172532  IN      NS      ns-945.awsdns-54.net.
devopsk8.com.           172532  IN      NS      ns-1991.awsdns-56.co.uk.
devopsk8.com.           172532  IN      NS      ns-157.awsdns-19.com.
devopsk8.com.           172532  IN      NS      ns-1442.awsdns-52.org.

$ dig soa devopsk8.com | egrep "ANSWER SECTION" -A 2
;; ANSWER SECTION:
devopsk8.com.           820     IN      SOA     ns-157.awsdns-19.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
```


- Install binary

```bash
$ brew update && brew install kops

$ kops version            
Version 1.19.1

```


#### Set IAM User

```bash
AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxx
AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxx
```



- Create the IAM role which gives the keys

```bash
aws configure
```


- Create the bucket 

```bash
$ bucket_name=k8-kops-stage-test
```

```bash
$ aws s3api create-bucket --bucket ${bucket_name} --region us-east-1  
{
    "Location": "/k8-kops-stage-test"
}
```

- Enable versioning

```bash
$ aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Enabled 
```



- Create the cluster

```bash
$ export KOPS_CLUSTER_NAME=k8.devopsk8.com     
$ export KOPS_STATE_STORE=s3://${bucket_name}
$ kops create cluster --node-count=1 --node-size=c5.2xlarge --master-count=1 --master-size=c5.xlarge --zones=eu-west-1a --name=${KOPS_CLUSTER_NAME} --yes
.
.
I0320 14:13:03.437182   44597 create_cluster.go:713] Using SSH public key: /Users/ankitsinghrathi/.ssh/id_rsa.pub
.
.
kops has set your kubectl context to k8.devopsk8.com

Cluster is starting.  It should be ready in a few minutes.

Suggestions:
 * validate cluster: kops validate cluster --wait 10m
 * list nodes: kubectl get nodes --show-labels
 * ssh to the master: ssh -i ~/.ssh/id_rsa ubuntu@api.k8.devopsk8.com
 * the ubuntu user is specific to Ubuntu. If not using Ubuntu please use the appropriate user based on your OS.
 * read about installing addons at: https://kops.sigs.k8s.io/operations/addons.
```


- Validate the cluster

```bash
kops validate cluster --wait 10m
.
.

W0320 14:18:53.164348   44767 validate_cluster.go:173] (will retry): unexpected error during validation: unable to resolve Kubernetes cluster API URL dns: lookup api.k8.devopsk8.com: no such host
INSTANCE GROUPS
NAME                    ROLE    MACHINETYPE     MIN     MAX     SUBNETS
master-eu-west-1a       Master  c5.xlarge       1       1       eu-west-1a
nodes-eu-west-1a        Node    c5.2xlarge      1       1       eu-west-1a

NODE STATUS
NAME                                            ROLE    READY
ip-172-20-54-246.eu-west-1.compute.internal     master  True
ip-172-20-55-44.eu-west-1.compute.internal      node    True

Your cluster k8.devopsk8.com is ready
```

- Delete the cluster

```bash
kops delete cluster --name ${KOPS_CLUSTER_NAME} --yes
```

- Export a kubeconfig with admin priviledges, (Note this would have a TTL)

```bash
$ kops export kubecfg --admin --kubeconfig ~/workspace/kubeconfig --state=s3://${bucket_name}
```



