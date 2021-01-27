#### We will create S3 bucket using cloudposse module. We will also have IAM user which will have admin priviledges on S3 bucket

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


- Uploading object
```bash
AWS_ACCESS_KEY_ID=<access-key-id>  AWS_SECRET_ACCESS_KEY=<secret-access-key>  aws s3 cp hello.txt s3://test-dev-backup-bucket/hello.txt
upload: ./hello.txt to s3://test-dev-backup-bucket/hello.txt    
```

- Get the object
```bash
$ AWS_ACCESS_KEY_ID=<access-key-id> AWS_SECRET_ACCESS_KEY=<secret-access-key> aws s3 cp  s3://test-dev-backup-bucket/hello.txt .
download: s3://test-dev-backup-bucket/hello.txt to ./hello.txt 
```

- list files
```bash
$ AWS_ACCESS_KEY_ID=<access-key-id> AWS_SECRET_ACCESS_KEY=<secret-access-key> aws s3 ls s3://test-dev-backup-bucket/hello.txt              
2021-01-25 12:39:54         12 hello.txt
```

- Delete the object
```bash
$ AWS_ACCESS_KEY_ID=<access-key-id> AWS_SECRET_ACCESS_KEY=<secret-access-key> aws s3 rm s3://test-dev-backup-bucket/hello.txt
delete: s3://test-dev-backup-bucket/hello.txt
```


