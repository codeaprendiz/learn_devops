

variable "region" {
  default = "us-central1"
}

variable "project_id" {
  description = "GCP Project used to create resources."
}

variable "image_family" {
  description = "Image used for compute VMs."
  default     = "debian-11"
}

variable "image_project" {
  description = "GCP Project where source image comes from."
  default     = "debian-cloud"
}
