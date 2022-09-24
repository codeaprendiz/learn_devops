# terraform-kitchen



## Learning Tasks


| S.No | Stack                                                                       | Tasks                                                                                                                                                                            | 
|------|-----------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| 
| 1    | Commands                                                                    | [Commands](task-set/task-000-commands/ReadMe.md)                                                                                                                                 |
| 2    | Initialization                                                              | [Setting up IAM user for terraform](task-set/task-000-initialization-setup)                                                                                                      |
| 3    | EC2, Datasource                                                             | [Create an EC2 instance by using AWS data source to choose the AMI](task-set/task-001-vars-provider-ec2-dataSources)                                                             |
| 4    | VPC default, Subnet, Security Group, KeyPair, EC2                           | [Create EC2 instance in default VPC and login](task-set/task-002-defaultVPC-sbnt-sg-kp-ec2)                                                                                      |                                                               
| 5    | VPC default, Subnet, Security Group, KeyPair, EC2 Script                    | [Create EC2 instance in default VPC and run a script](task-set/task-003-defaultVPC-kp-sbnt-sg-ec2-script)                                                                        |                          
| 6    | EC2, Output, Local File                                                     | [Create EC2 instance, save private IP in local file](task-set/task-004-vars-provider-ec2-output)                                                                                 | 
| 7    | EC2, State, S3                                                              | [Create EC2 instance and save the remote state in an S3 bucket created manually](task-set/task-005-vars-provider-ec2-remoteStateInS3)                                            | 
| 8    | VPC default, Subnets, Module                                                | [Create default VPC and subnets using module](task-set/task-006-defaultVPC-defaultSbnt-modules-kp)                                                                               |
| 9    | VPC custom, Internet Gateway, Routetables, Subnet, EC2, Login               | [Custom VPC with EC2, routetables, Internet Gateway](task-set/task-007-customVPC-igw-sbnt-rt-sg-kp-ec2)                                                                          
| 10   | VPC custom, Pub & Pri Subnet, NAT, Internet Gateway, Elastic IP             | [Custom VPC with public and private subnet, nat gateway, internet gateway, Elastic IP ](task-set/task-008-customVPC-3PriSbnts-3PubSbnts-nat-igw-rt)                              
| 11   | VPC custom, Pub & Pri Subnet, NAT, Internet Gateway, Elastic IP, EBS        | [Custom VPC with public and private subnet, nat gateway, internet gateway, Elastic IP, EBS](task-set/task-009-customVPC-3PriSbnts-3PubSbnts-nat-igw-rt-ec2-ebs)                  
| 12   | VPC custom, Pub & Pri Subnet, NAT, Internet Gateway, Elastic IP, EBS, Mount | [Custom VPC with public and private subnet, nat gateway, internet gateway, Elastic IP, EBS, Mount](task-set/task-010-customVPC-3PriSbnts-3PubSbnts-nat-igw-rt-ec2-ebs-withMount) | 
| 13   | Route53 Hosted Zone                                                         | [Create a hosted zone and get the list of name servers](task-set/task-011-route53)
| 14   | EC2, RDS, Pub & Pri Subnet, VPC                                             | [Create RDS in pri subnet, EC2 in public subnet](task-set/task-012-rds-vpc-ec2)
| 15   | Users, Groups, Policies                                                     | [Create users, groups, policy](task-set/task-013-IAM)
| 16   | EC2, IAM Role, Private S3                                                   | [Attach IAM role to EC2 to upload objects to private S3](task-set/task-014-IAM-roles-s3-upload-to-s3)
| 17   | Autoscaling Group, Cloudwatch Alarms, Launch Configuration, EC2, SNS        | [Autoscaling Group, Cloudwatch Alarms, Launch Configuration, EC2](task-set/task-015-autoscaling-cloudwatchAlarm-ec2-launchConfiguration)
| 18   | Autoscaling Group, ELB, VPC                                                 | [Autoscaling Group, ELB](task-set/task-016-ELB-autoscaling)
| 19   | ElasticBeanStalk                                                            | [ElasticBeanStalk](task-set/task-017-Elastic-Beanstalk)
| 20   | ECR                                                                         | [ECR Repo](task-set/task-018-create-ECR-repo)
| 21   | S3, IAM, Modules                                                            | [Create S3 bucket with IAM policy to access the bucket](aws/task-020-s3-iam-using-modules)                     |

Kubernetes Typhoon| [Create kubernetes cluster using typhoon kubernetes](aws/task-021-k8s-cluster-typhoon)                         |
Route53 EC2 | [To create Route53 record to access EC2 instance](aws/task-022-route53-ec2)                                    | 
AWS Certificate Manager | [Create a private certificate for your Domain using AWS Certificate Manager](aws/task-024-certificate-manager) |



### Terragrunt Implementation

Topic | Tasks | 
---    | --- | 
EC2  | [Create ec2 instance in default VPC](aws/task-023-terragrunt-ec2) |
S3 IAM | [Create IAM User for already existing S3 bucket](aws/task-025-terragrunt-iam-user) |
S3 | [Create S3 bucket](aws/task-026-terragrunt-s3-bucket) |
Route53 EC2 | [To create Route53 record to access EC2 instance](aws/task-022-route53-ec2) | 
AWS Certificate Manager | [Create a private certificate for your Domain using AWS Certificate Manager](aws/task-024-certificate-manager) |
CDN | [To create CDN](aws/task-027-terragrunt-cdn) | 
EKS | [To create EKS cluster](aws/task-030-creating-eks)
EKS using Spot and Ondemand | [To create EKS cluster using spot and on demand instance types](aws/task-031-creating-eks-spot)




### Frequently visited
- [Amazon EC2 AMI Locator](http://cloud-images.ubuntu.com/locator/ec2/)

### Tutorial Links

[learn.hashicorp.com/terraform](https://learn.hashicorp.com/terraform)
[tutorials/terraform/sensitive-variables](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables)



### Terraform Doc References

- [data sources](https://www.terraform.io/docs/configuration/data-sources.html)
    - [aws_ami](https://www.terraform.io/docs/providers/aws/d/ami.html)
    - [template_cloudinit_config](https://www.terraform.io/docs/providers/template/d/cloudinit_config.html)
    - [template_file](https://www.terraform.io/docs/providers/template/d/file.html)
- [provider](https://www.terraform.io/docs/providers/index.html)
    - [aws](https://www.terraform.io/docs/providers/aws/index.html)
- [modules](https://www.terraform.io/docs/configuration/modules.html)
- [resources](https://www.terraform.io/docs/configuration/resources.html)
    - [aws_autoscaling_group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)
    - [aws_autoscaling_policy](https://www.terraform.io/docs/providers/aws/r/autoscaling_policy.html)
    - [aws_autoscaling_notification](https://www.terraform.io/docs/providers/aws/r/autoscaling_notification.html)
    - [aws_cloudwatch_metric_alarm](https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html)
    - [aws_db_instance](https://www.terraform.io/docs/providers/aws/r/db_instance.html)
    - [aws_db_parameter_group](https://www.terraform.io/docs/providers/aws/r/db_parameter_group.html)
    - [aws_db_subnet_group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)
    - [aws_default_subnet](https://www.terraform.io/docs/providers/aws/r/default_subnet.html)
    - [aws_default_vpc](https://www.terraform.io/docs/providers/aws/r/default_vpc.html)
    - [aws_ebs_volume](https://www.terraform.io/docs/providers/aws/r/ebs_volume.html)
    - [aws_eip](https://www.terraform.io/docs/providers/aws/r/eip.html)
    - [aws_iam_group](https://www.terraform.io/docs/providers/aws/r/iam_group.html)
    - [aws_iam_group_membership](https://www.terraform.io/docs/providers/aws/r/iam_group_membership.html)
    - [aws_iam_instance_profile](https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html)
    - [aws_iam_policy_attachment](https://www.terraform.io/docs/providers/aws/r/iam_policy_attachment.html)
    - [aws_iam_role](https://www.terraform.io/docs/providers/aws/r/iam_role.html)
    - [aws_iam_role_policy](https://www.terraform.io/docs/providers/aws/r/iam_role_policy.html)
    - [aws_iam_user](https://www.terraform.io/docs/providers/aws/r/iam_user.html)
    - [aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
    - [aws_internet_gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
    - [aws_key_pair](https://www.terraform.io/docs/providers/aws/r/key_pair.html)
    - [aws_launch_configuration](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)
    - [aws_nat_gateway](https://www.terraform.io/docs/providers/aws/r/nat_gateway.html)
    - [aws_route53_zone](https://www.terraform.io/docs/providers/aws/r/route53_zone.html)
    - [aws_route53_record](https://www.terraform.io/docs/providers/aws/r/route53_record.html)
    - [aws_route_table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
    - [aws_route_table_association](https://www.terraform.io/docs/providers/aws/r/route_table_association.html)
    - [aws_security_group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
    - [aws_sns_topic](https://www.terraform.io/docs/providers/aws/r/sns_topic.html)
    - [aws_subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
    - [aws_volume_attachment](https://www.terraform.io/docs/providers/aws/r/volume_attachment.html)
    - [aws_vpc](https://www.terraform.io/docs/providers/aws/r/vpc.html)
- variables
    - [input variables](https://www.terraform.io/docs/configuration/variables.html)












