# Terraform: Create a Virtual Cloud Network

[Create a Virtual Cloud Network](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-vcn/01-summary.htm)

<br>

## Key tasks include how to:

- Set up a basic virtual cloud network.
- Define and add the following resources to the network:
  - Security lists
  - Private and public subnets


Browse module

- [oracle-terraform-modules/vcn/oci/3.5.1](https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/3.5.1)

```bash
╰─ terraform apply -var-file=$OCI_TFVARS_LOCATION/terraform.tfvars
```