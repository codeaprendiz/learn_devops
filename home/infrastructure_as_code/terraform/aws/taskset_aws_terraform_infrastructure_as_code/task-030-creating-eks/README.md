# Learn Terraform - Provision an EKS Cluster

[learn creating eks](https://learn.hashicorp.com/tutorials/terraform/eks)
[vpc](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
[eks](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
[spot and on-demand blog](https://aws.amazon.com/blogs/compute/run-your-kubernetes-workloads-on-amazon-ec2-spot-instances-with-amazon-eks/)



- Init

```bash
./run.sh init
```

- Apply 

```bash
./run.sh apply
.
.
Apply complete! Resources: 51 added, 0 changed, 0 destroyed.
.
.

```

- Get the kubeconfig

```bash
$ aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name) --kubeconfig kubeconfig
```

- Get the nodes

```bash
$ kubectl get nodes --kubeconfig=./kubeconfig                       
NAME                         STATUS   ROLES    AGE     VERSION
ip-10-0-1-140.ec2.internal   Ready    <none>   4m20s   v1.20.4-eks-6b7464
ip-10-0-2-35.ec2.internal    Ready    <none>   4m38s   v1.20.4-eks-6b7464
ip-10-0-3-91.ec2.internal    Ready    <none>   4m57s   v1.20.4-eks-6b7464

$ kubectl get pods -n kube-system --kubeconfig=./kubeconfig
NAME                       READY   STATUS    RESTARTS   AGE
aws-node-8dsqn             1/1     Running   0          7m42s
aws-node-j8vmm             1/1     Running   0          7m6s
aws-node-q45sf             1/1     Running   0          7m24s
coredns-65bfc5645f-2twrg   1/1     Running   0          11m
coredns-65bfc5645f-p7ngx   1/1     Running   0          11m
kube-proxy-5jbzj           1/1     Running   0          7m42s
kube-proxy-hq79m           1/1     Running   0          7m24s
kube-proxy-r6rwq           1/1     Running   0          7m6s


```



