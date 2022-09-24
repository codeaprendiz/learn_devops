//We are going to create VPC with defined CIDR block, enable DNS support and DNS hostnames so each instance can have a DNS name along with IP address.

// https://www.terraform.io/docs/providers/aws/r/vpc.html

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Environment = var.environment_tag
  }
}

