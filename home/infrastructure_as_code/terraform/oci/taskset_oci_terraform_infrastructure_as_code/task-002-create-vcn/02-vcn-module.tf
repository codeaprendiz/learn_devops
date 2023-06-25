# Source from https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/
module "vcn"{
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.5.1"
  # insert the 5 required variables here

  # Required Inputs
  compartment_id = var.TF_VAR_COMPARTMENT_SANDBOX_TF_V1_OCI_ID
  region = var.TF_VAR_REGION

  internet_gateway_route_rules = null
  local_peering_gateways = null
  nat_gateway_route_rules = null

  # Optional Inputs
  vcn_name = "sandbox-tf-v1-vcn"
  vcn_dns_label = "sandboxvcnlabel"
  vcn_cidrs = ["10.0.0.0/16"]
  
  create_internet_gateway = true
  create_nat_gateway = false
  create_service_gateway = false  
}