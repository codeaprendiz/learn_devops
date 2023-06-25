//Internet gateway needs to be added inside VPC which can be used by subnet to access the internet from inside.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Environment = var.environment_tag
  }
}