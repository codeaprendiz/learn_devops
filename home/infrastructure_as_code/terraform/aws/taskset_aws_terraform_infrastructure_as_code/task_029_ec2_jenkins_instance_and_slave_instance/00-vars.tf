variable "region" {
  default = "eu-west-1"
}

variable "subnet" {
  description = "The subnet where instance would be created"
  type        = string
//  sensitive   = true
}

variable "vpc" {
  description = "VPC"
  type        = string
//  sensitive   = true
}


variable "hosted_zone_id" {
  description = "Hosted Zone ID"
  type        = string
  //  sensitive   = true
}




