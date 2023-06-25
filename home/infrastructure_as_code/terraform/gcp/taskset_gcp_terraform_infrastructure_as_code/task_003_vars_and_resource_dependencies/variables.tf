variable "instance_name" {
  type        = string
  description = "Name for the Google Compute instance"
}
variable "instance_zone" {
  type        = string
  description = "Zone for the Google Compute instance"
}
variable "instance_type" {
  type        = string
  description = "Disk type of the Google Compute instance"
  default     = "n1-standard-1"
}