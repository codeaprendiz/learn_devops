// from ENV



variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "us-east-2a"
}
variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/id_rsa.pub"
}
variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-0cf31d971a3ca20d6"
}
variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}