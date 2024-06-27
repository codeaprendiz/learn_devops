# Create a compartment

[Create compartment](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-compartment/01-summary.htm)

<br>

## Key tasks include how to:

Use Oracle Cloud Infrastructure Terraform provider resources to:
- Declare a compartment with your specifics.
- Create the compartment in your tenancy.

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


