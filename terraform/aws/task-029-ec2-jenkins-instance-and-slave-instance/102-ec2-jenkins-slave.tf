//variable "jenkins-slave-instance-count" {
//  default = 1
//}
//
////variable "jenkins-slave-private-ips" {
////  default = [
////    "172.31.47.221"
////  ]
////}
//
//module "ec2-jenkins-slave" {
//  source  = "terraform-aws-modules/ec2-instance/aws"
//  version = "~> 2.15"
//
//  name           = "dev-jenkins-slave"
//  instance_count = var.jenkins-slave-instance-count
//  use_num_suffix = true
//
//  ami           = data.aws_ami.ubuntu-bionic-latest.id
//  instance_type = "t2.micro"
//  key_name      = "jenkins.pem.pub"
//  monitoring    = true
//
//  vpc_security_group_ids = [
//    module.security-group-jenkins-slave.this_security_group_id
//  ]
//  subnet_id = var.subnet
//
////  private_ips = var.jenkins-slave-private-ips
//
//  associate_public_ip_address = true
//
//  root_block_device = [
//    {
//      volume_type = "gp2"
//      volume_size = 30
//    },
//  ]
//
//  tags = {
//    name        = "dev-jenkins-slave"
//    terraform   = "true"
//    environment = "stage"
//    domain      = "jenkins-slave.ankitrathi.info"
//    project     = "stage jenkins-slave"
//    application = "jenkins-slave"
//    team        = "devops"
//  }
//}
//
////resource "aws_eip" "dev-jenkins-slave-eip" {
////  vpc      = true
////  instance = module.ec2-jenkins-slave.id[0]
////}
//
//resource "aws_ebs_volume" "ec2-ebs-jenkins-slave" {
//  count = var.jenkins-slave-instance-count
//
//  availability_zone = module.ec2-jenkins-slave.availability_zone[count.index]
//  size              = 50
//}
//
//resource "aws_volume_attachment" "ec2-ebs-attachment-jenkins-slave" {
//  count = var.jenkins-slave-instance-count
//
//  device_name = "/dev/sdh"
//  volume_id   = aws_ebs_volume.ec2-ebs-jenkins-slave[count.index].id
//  instance_id = module.ec2-jenkins-slave.id[count.index]
//}
//
//
//output "ec2-jenkins-slave-public_dns" {
//  value = module.ec2-jenkins-slave.public_dns
//}
