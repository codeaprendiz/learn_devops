# Deploy Kubernetes Load Balancer Service with Terraform


[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Quest -  Managing Cloud Infrastructure with Terraform](https://www.cloudskillsboost.google/paths)

**High Level Objectives**

- Deploy a Kubernetes cluster along with a service using Terraform

**Skills**

- Kubernetes cluster
- Service
- terraform

**Version Stack**

| Stack     | Version |
|-----------|---------|
| Terraform | 1.3.9   |

## Clone the sample code

```bash
gsutil -m cp -r gs://spls/gsp233/* .

cd tf-gke-k8s-service-lb
```


## Understand the code


## Initialize and install dependencies

```bash
terraform init


terraform apply -var="region=us-central1" -var="location=us-central1-f"
```

- Verify resources created by Terraform


