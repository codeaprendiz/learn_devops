

//https://www.terraform.io/docs/providers/aws/r/default_vpc.html

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

