// The subnet is added inside VPC with its own CIDR block which is a subset of VPC CIDR block inside given availability zone.

resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone
  tags = {
    Environment = var.environment_tag
  }
}