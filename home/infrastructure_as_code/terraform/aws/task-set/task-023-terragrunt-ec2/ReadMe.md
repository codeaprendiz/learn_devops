### Use Terragrunt to create an EC2 instance in default VPC

- Versions
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
.
Plan: 1 to add, 0 to change, 0 to destroy.
```

- Applying the changes
```bash
$ ./run.sh apply
.
  + create
.
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

- Destroy the changes
```bash
$ ./run.sh destroy
.
Destroy complete! Resources: 1 destroyed.
```