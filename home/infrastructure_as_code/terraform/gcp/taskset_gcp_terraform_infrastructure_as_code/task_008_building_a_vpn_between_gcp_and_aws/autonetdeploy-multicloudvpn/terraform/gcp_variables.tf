

/*
 * Terraform variable declarations for GCP.
 */

variable "gcp_credentials_file_path" {
  description = "Locate the GCP credentials .json file."
  type        = string
}

variable "gcp_project_id" {
  description = "GCP Project ID."
  type        = string
}

variable "gcp_region" {
  description = "Default to Oregon region."
  default     = "us-central1"
}

variable "gcp_instance_type" {
  description = "Machine Type. Correlates to an network egress cap."
  default     = "n1-standard-1"
}

variable "gcp_disk_image" {
  description = "Boot disk for gcp_instance_type."
  default     = "projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts"
}

variable "gcp_network_cidr" {
  default = "10.240.0.0/16"
}

variable "gcp_subnet1_cidr" {
  default = "10.240.0.0/24"
}

variable "gcp_vm_address" {
  description = "Private IP address for GCP VM instance."
  default     = "10.240.0.100"
}

variable "GCP_TUN1_VPN_GW_ASN" {
  description = "Tunnel 1 - Virtual Private Gateway ASN, from the AWS VPN Customer Gateway Configuration"
  default     = "64512"
}

variable "GCP_TUN1_CUSTOMER_GW_INSIDE_NETWORK_CIDR" {
  description = "Tunnel 1 - Customer Gateway from Inside IP Address CIDR block, from AWS VPN Customer Gateway Configuration"
  default     = "30"
}

variable "GCP_TUN2_VPN_GW_ASN" {
  description = "Tunnel 2 - Virtual Private Gateway ASN, from the AWS VPN Customer Gateway Configuration"
  default     = "64512"
}

variable "GCP_TUN2_CUSTOMER_GW_INSIDE_NETWORK_CIDR" {
  description = "Tunnel 2 - Customer Gateway from Inside IP Address CIDR block, from AWS VPN Customer Gateway Configuration"
  default     = "30"
}

