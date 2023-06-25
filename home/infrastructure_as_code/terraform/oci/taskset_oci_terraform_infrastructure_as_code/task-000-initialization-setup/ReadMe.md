# Initialization Setup

[Initialization](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)


- Version

```bash
╰─ terraform -version
Terraform v1.1.9
on darwin_arm64
```

- Create tfvars file and note it's location

```bash
╰─ cat terraform.tfvars           
TF_VAR_TENANCY_OCID="****************************"
TF_VAR_USER_OCID="*****************************"
TF_VAR_PRIVATE_KEY_PATH="*****************"
TF_VAR_FINGERPRINT="******************"
TF_VAR_REGION="***************"
```



- Terraform init, plan, apply

```bash
╰─ terraform init


╰─ terraform plan -var-file=$OCI_TFVARS_LOCATION/terraform.tfvars

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your
configuration and found no differences, so no changes are needed


╰─ terraform apply -var-file=$OCI_TFVARS_LOCATION/terraform.tfvars

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your
configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```