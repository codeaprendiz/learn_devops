### Create k8s cluster using kops

[production-environment/tools/kops](https://kubernetes.io/docs/setup/production-environment/tools/kops/)

[getting_started/install](https://kops.sigs.k8s.io/getting_started/install/)


#### Pre-requisite

You should own a domain for example in this case I own `devopsk8.com`

```bash

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
$ bucket_name=kops-stage-test

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


- export KOPS_CLUSTER_NAME=k8.tradelingk8.com

- Create the cluster

```bash
kops create cluster --name=kubernetes.ankitrathi.info --state=s3://kops-ankitrathi-info-state-store --zones=eu-west-1a --node-count=1 --node-size=t2.micro --master-size=t2.micro --dns-zone=xxxxxxxxxxx --yes
```


- Validate the cluster

```bash
kops validate cluster --wait 10m
```

- Delete the cluster

```bash
kops delete cluster --name kubernetes.ankitrathi.info --yes
```



