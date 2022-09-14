
resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = var.TF_VAR_TENANCY_OCID
    description = "Compartment for Terraform resources."
    name = "sandbox-tf-v1"
}