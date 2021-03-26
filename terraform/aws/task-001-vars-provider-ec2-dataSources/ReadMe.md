## OBJECTIVE : 
- To create an EC2 instance using resource 
- To use the data source [aws_ami](https://www.terraform.io/docs/providers/aws/d/ami.html) to get the AMI ID
of the instance we want to create



## The following commands will be executed.

- Initialization

```bash
$ terraform init -var-file=../../terraform.tfvars
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

- Verifying the instance created by logging into the console

![](../../../images/terraform/aws/task-001-vars-provider-ec2-dataSources/instance_details_screen.png)


- Destroy
```bash
$ terraform destroy -var-file=../../terraform.tfvars
...
  Enter a value: yes
...
Destroy complete! Resources: 1 destroyed.
```