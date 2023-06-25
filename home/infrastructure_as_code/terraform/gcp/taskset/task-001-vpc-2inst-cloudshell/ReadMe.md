# Using Terraform in GCP console

**High Level Objectives**

- Create a VPC network
- Attached Internet Gateway 
- Instances in 2 regions with subnets created using auto-mode

**Skills**
- VPC
- Internet Gateway
- instances
- subnets using auto-mode
- terraform

**Version Stack**

| Stack     | Version |
|-----------|---------|
| Terraform | 1.3.4   |


![infra-diagram.png](.images/infra-diagram.png)


- Let's go through the code together

- Begin

```bash
terraform --version
```

- Create the required files

```bash
terraform init

terraform plan

terraform apply
```

- View the resources created on the console

- SSH into the instance

```bash
ping google.com  # So we have internet access

## SSH into one instance and

ping <OTHER_SERVER_EXTERNAL_IP
```