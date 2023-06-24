### kops

- The objective is to udpate the cluster resources of KOPS K8S cluster

```bash
# validating cluster without setting environment variables
export KUBECONFIG=~/workspace/kops/_kube/dev/kubeconfig
AWS_ACCESS_KEY_ID=<aws_access_key> AWS_SECRET_ACCESS_KEY=<aws_secret_key> kops validate cluster --wait 10m --state="s3://my-kops-bucket-v1" --name=k8.mydomain.com

## creating cluster
### Ensure that the bucket name is unique
bucket_name=devops-test-company
export AWS_SECRET_KEY=<aws_secret_key>
export AWS_ACCESS_KEY=<aws_access_key>
aws s3api create-bucket --bucket ${bucket_name} --region us-east-1
aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Enabled
export KOPS_CLUSTER_NAME=k8.mydomain.com
export KOPS_STATE_STORE=s3://${bucket_name}
kops create cluster --node-count=1 --node-size=t3.medium --master-count=1 --master-size=t3.medium --zones=us-east-1a --name=${KOPS_CLUSTER_NAME} --yes
kops validate cluster --wait 10m

## updating instance size
kops get instancegroups
## edit the size of instance group and save the file
kops edit ig nodes-us-east-1a
kops get instancegroups
kops update cluster --name=${KOPS_CLUSTER_NAME}
kops update cluster --name=${KOPS_CLUSTER_NAME} --yes
kops rolling-update cluster --name=${KOPS_CLUSTER_NAME}
kops rolling-update cluster --name=${KOPS_CLUSTER_NAME} --yes
kops get instancegroups

## updating the number of instances
kops edit ig nodes-us-east-1a
## edit the minSize and maxSize
kops get instancegroups      
kops update cluster --name=${KOPS_CLUSTER_NAME}
kops update cluster --name=${KOPS_CLUSTER_NAME} --yes
```