// https://www.terraform.io/docs/providers/aws/r/default_subnet.html

resource "aws_default_subnet" "default_az1" {
  availability_zone = var.availability_zone

  tags = {
    Name = "Default subnet for us-east-2a"
  }
}