variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}



