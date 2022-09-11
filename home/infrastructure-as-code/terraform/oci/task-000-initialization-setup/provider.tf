provider "oci" {
  tenancy_ocid = var.TF_VAR_TENANCY_OCID 
  user_ocid = var.TF_VAR_USER_OCID
  private_key_path = var.TF_VAR_PRIVATE_KEY_PATH
  fingerprint = var.TF_VAR_FINGERPRINT
  region = var.TF_VAR_REGION
}

terraform {
    required_providers {
        oci = {
            source  = "oracle/oci"
            version = ">= 4.0.0"
        }
    }
}