provider "aws" {
  region = var.AWS_REGION
}


/* ******************************************************************************************************************
 * You need to install the terraform-provider-ct plugin
 * You can use this link for installation instructions on the same - https://github.com/poseidon/terraform-provider-ct
 ******************************************************************************************************************** */
provider "ct" {
  version = "0.5.1"
}
