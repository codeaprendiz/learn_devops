## Objective 


1) To create S3 bucket using an S3 git module `git::https://github.com/cloudposse/terraform-aws-s3-bucket.git?ref=master`
2) Create one admin user using this module. The admin user should have all access priviledges to the S3 bucket.
3) Get the `data` of the created bucket to create a `bucket` object
4) Create one DEV IAM user with limited access priviledges to the S3 bucket. You can use the following
module for the same `git::https://github.com/cloudposse/terraform-aws-iam-s3-user.git?ref=master`
5) Print the access keys and the name of the bucket at the end.


- s3-bucket.tf

```hcl-terraform
module "s3_bucket_data" {
  source                   = "git::https://github.com/cloudposse/terraform-aws-s3-bucket.git?ref=master"
  enabled                  = true
  user_enabled             = true
  versioning_enabled       = false
  allowed_bucket_actions   = ["s3:*"]
  name                     = "backup-bucket"
  stage                    = "dev"
  namespace                = "data"

}

data "aws_s3_bucket" "data-backup-bucket" {
  bucket = module.s3_bucket_data.bucket_id
}

module "data-backup-bucket-user" {
  source    = "git::https://github.com/cloudposse/terraform-aws-iam-s3-user.git?ref=master"
  namespace = "data"
  stage     = "dev"
  name      = "backup-bucket-readonly-user"
  s3_actions = [
    "s3:GetObject",
    "s3:ListBucket",
    "s3:GetBucketLocation"
  ]
  s3_resources = [
    "${data.aws_s3_bucket.data-backup-bucket.arn}/*",
    data.aws_s3_bucket.data-backup-bucket.arn
  ]
}

output "aws-developer-data-access-key" {
  value = module.data-backup-bucket-user.access_key_id
}

output "aws-developer-data-secret-key" {
  value = module.data-backup-bucket-user.secret_access_key
}

output "aws-s3-data-bucket-url" {
  value = module.s3_bucket_data.bucket_domain_name
}

output "aws-admin-data-access-key" {
  value = module.s3_bucket_data.access_key_id
}

output "aws-admin-data-secret-key" {
  value = module.s3_bucket_data.secret_access_key
}
```


- Init

```bash
$ terraform init 
Initializing modules...
Downloading git::https://github.com/cloudposse/terraform-aws-iam-s3-user.git?ref=master for data-backup-bucket-user...
- data-backup-bucket-user in .terraform/modules/data-backup-bucket-user
.
.
.

```

- Plan

```                                 
$ terraform plan 
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Enter a value: us-east-1
.
.
.
Plan: 8 to add, 0 to change, 0 to destroy.
```


- Apply
```bash
$ terraform apply 
.
.
.
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

aws-admin-data-access-key = ****************
aws-admin-data-secret-key = *****************
aws-developer-data-access-key = ******************
aws-developer-data-secret-key = ****************
aws-s3-data-bucket-url = data-dev-backup-bucket.s3.amazonaws.com

```



- Destroy
```bash
$ terraform destroy                                 
Destroy complete! Resources: 8 destroyed.
```