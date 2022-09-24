module "security-group-jenkins" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.17"

  name        = "security-group-jenkins"
  description = "security-group-jenkins"
  vpc_id      = var.vpc

  ingress_cidr_blocks = [
    "0.0.0.0/0",
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Jenkins-agent ports"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Jenkins-agent ports"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Jenkins-agent ports"
    },
    {
      from_port   = 50001
      to_port     = 50001
      protocol    = "tcp"
      description = "Jenkins-agent ports"
    }
  ]

  egress_rules = [
    "all-all"
  ]
}



module "security-group-jenkins-slave" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.17"

  name        = "security-group-jenkins-slave"
  description = "security-group-jenkins-slave"
  vpc_id      = var.vpc

  ingress_cidr_blocks = [
    "0.0.0.0/0",
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Jenkins-agent ports"
    },
    {
      from_port   = 50001
      to_port     = 50001
      protocol    = "tcp"
      description = "Jenkins-agent ports"
    }
  ]

  egress_rules = [
    "all-all"
  ]
}