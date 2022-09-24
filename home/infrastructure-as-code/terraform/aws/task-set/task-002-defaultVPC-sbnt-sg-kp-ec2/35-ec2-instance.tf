// Once everything is ready, let us start an EC2 instance within our public subnet with created key pair and security group.

data "aws_ami" "ubuntu-bionic-latest" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


// Login with ubuntu@PUBLIC_IP
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu-bionic-latest.id
  instance_type = var.instance_type
  subnet_id = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  key_name = aws_key_pair.ec2key.key_name

  tags = {
    Name = "DroneCI"
  }
}

