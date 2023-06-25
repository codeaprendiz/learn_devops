variable "AWS_REGION" {
  default = "us-east-1"
}

variable "domain_mydevops_link" {
  default = "codeaprendiz.tk"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}