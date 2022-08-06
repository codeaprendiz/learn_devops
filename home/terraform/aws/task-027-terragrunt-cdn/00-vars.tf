variable "region" {
  default = "eu-west-1"
}


variable "public_hosted_zone_id" {
  description = "ID of the Public Hosted Zone"
  type        = string
  sensitive   = true
}


variable "private_certificate_arn" {
  description = "ARN of the private certificate issued by AWS Certificate Manager"
  type        = string
  sensitive   = true
}
