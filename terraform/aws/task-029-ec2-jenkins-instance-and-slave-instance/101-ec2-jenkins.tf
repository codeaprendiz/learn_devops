variable "jenkins-instance-count" {
  default = 1
}

//variable "jenkins-private-ips" {
//  default = [
//    "172.31.2.201"
//  ]
//}

module "tools-ec2-jenkins" {
  source         = "terraform-aws-modules/ec2-instance/aws"
  version        = "~> 2.15"
  name           = "dev-jenkins"
  instance_count = var.jenkins-instance-count
  use_num_suffix = true

  ami           = data.aws_ami.ubuntu-bionic-latest.id
  instance_type = "t2.micro"
  key_name      = "jenkins.pem.pub"
  monitoring    = true

  vpc_security_group_ids = [
    module.security-group-jenkins.this_security_group_id,
  ]
  subnet_id = var.subnet

//  private_ips = var.jenkins-private-ips

  associate_public_ip_address = true

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 30
    },
  ]

  tags = {
    name        = "dev-jenkins"
    terraform   = "true"
    environment = "dev"
    domain      = "jenkins.ankitrathi.info"
    project     = "dev jenkins"
    application = "jenkins"
    team        = "devops"
  }
}

resource "aws_eip" "tools-ec2-jenkins-eip" {
  vpc      = true
  instance = module.tools-ec2-jenkins.id[0]
}

resource "aws_ebs_volume" "ec2-ebs-jenkins" {
  count = var.jenkins-instance-count

  availability_zone = module.tools-ec2-jenkins.availability_zone[count.index]
  size              = 30
}

resource "aws_volume_attachment" "ec2-ebs-attachment-es-www" {
  count = var.jenkins-instance-count

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ec2-ebs-jenkins[count.index].id
  instance_id = module.tools-ec2-jenkins.id[count.index]
}

resource "aws_route53_record" "tools-jenkins-a-record" {
  zone_id = var.hosted_zone_id
  name    = "jenkins.ankitrathi.info"
  type    = "A"
  ttl     = "3600"

  records = [
    aws_eip.tools-ec2-jenkins-eip.public_ip
  ]

  depends_on = [
    module.tools-ec2-jenkins
  ]
}

//output "tools-ec2-jenkins-public_ip" {
//  value = aws_eip.tools-ec2-jenkins-eip.public_ip
//}

output "tools-ec2-jenkins-public_dns" {
  value = module.tools-ec2-jenkins.public_dns
}



