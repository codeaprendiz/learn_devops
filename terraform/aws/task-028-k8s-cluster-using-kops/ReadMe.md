### Create k8s cluster using kops

[production-environment/tools/kops](https://kubernetes.io/docs/setup/production-environment/tools/kops/)

[getting_started/install](https://kops.sigs.k8s.io/getting_started/install/)


#### Pre-requisite

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