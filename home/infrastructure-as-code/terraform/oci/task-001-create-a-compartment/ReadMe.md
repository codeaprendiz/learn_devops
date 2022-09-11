# Create a compartment

- Plan

```bash
╰─ terraform plan -var-file=$OCI_TFVARS_LOCATION/terraform.tfvars

  + create

Plan: 1 to add, 0 to change, 0 to destroy.
```

- Apply

```bash
╰─ terraform apply -var-file=$OCI_TFVARS_LOCATION/terraform.tfvars

  + create
  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
