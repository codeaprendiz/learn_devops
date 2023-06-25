# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet

resource "oci_core_subnet" "vcn-public-subnet"{

  # Required
  compartment_id = var.TF_VAR_COMPARTMENT_SANDBOX_TF_V1_OCI_ID
  vcn_id = module.vcn.vcn_id
  cidr_block = "10.0.0.0/24"
 
  # Optional
  route_table_id = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  display_name = "public-subnet"
}