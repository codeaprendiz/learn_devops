variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "availability_zone" {
  description = "availability zone to create subnet"
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default     = "t2.micro"
}


variable "PATH_TO_PRIVATE_KEY" {
  description = "Private key path"
  default     = "~/.ssh/id_rsa"
}

variable "PATH_TO_PUBLIC_KEY" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}


variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Development"
}



