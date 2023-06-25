## OBJECTIVE : 
- To create an EC2 instance.
- Save the remote state in an S3 bucket created manually.

## First manually create an S3 bucket by following steps

- Step1)

![](.ReadMe_images/s3-bucket-creation-screen.png)


## The following commands will be executed.

- Initialization

Before running `terraform init` you will have to run `aws configure`
```bash
$ aws configure
AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: us-east-1
Default output format [None]: 
```


```bash
$ terraform init
Initializing the backend...
region
  The region of the S3 bucket.

  Enter a value: us-east-1


Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
...
```

- Planning

```bash
$ terraform plan -var-file=../../terraform.tfvars
...
Plan: 1 to add, 0 to change, 0 to destroy.
...
```

- Apply
```bash
$ terraform apply -var-file=../../terraform.tfvars
...
Enter a value: yes
...
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
``` 


- Login and check if the remote state has been stored in the S3 bucket with the key `terraform-remote-state-key`

![](.ReadMe_images/terraform-remote-state-on-s3.png)


- Destroy
```bash
$ terraform destroy -var-file=../../terraform.tfvars
...
  Enter a value: yes
...
Destroy complete! Resources: 1 destroyed.
```