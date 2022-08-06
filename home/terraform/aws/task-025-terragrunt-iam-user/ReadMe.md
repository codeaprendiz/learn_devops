### Create an IAM user who will have certain defined access to the S3 bucket


- Terraform and Terragrunt versions
```bash
$ terraform --version
Terraform v0.14.4

Your version of Terraform is out of date! The latest version
is 0.14.5. You can update by downloading from https://www.terraform.io/downloads.html

$ terragrunt -version
terragrunt version v0.27.1
```


- Run the following. Initialization
```bash
$ chmod 755 run.sh          
$ ./run.sh init
```

- Plan
```bash
$ ./run.sh plan
```

- Applying the changes
```bash
$ ./run.sh apply
```

- Destroy the changes
```bash
$ ./run.sh destroy
```

- List objects in bucket
```bash
$ AWS_ACCESS_KEY_ID=<access-key-id> AWS_SECRET_ACCESS_KEY=<secret-access-key> aws s3 ls s3://test-dev-backup-bucket
2021-01-25 12:58:10          6 hello.txt
```

- Remove objects from bucket
```bash
$ AWS_ACCESS_KEY_ID=<access-key-id> AWS_SECRET_ACCESS_KEY=<secret-access-key> aws s3 rm s3://test-dev-backup-bucket/hello.txt
delete failed: s3://test-dev-backup-bucket/hello.txt An error occurred (AccessDenied) when calling the DeleteObject operation: Access Denied
```
