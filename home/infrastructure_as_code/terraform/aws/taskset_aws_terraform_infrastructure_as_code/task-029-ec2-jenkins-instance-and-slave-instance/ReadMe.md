### Use Terragrunt to create an EC2 instance in default VPC

- Create keys

```bash
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/user/.ssh/id_rsa): jenkins.pem
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in jenkins.pem.
Your public key has been saved in jenkins.pem.pub.

$ ls         
00-vars.tf               05-provider.tf           101-ec2-jenkins.tf       102-ec2-jenkins-slave.tf ReadMe.md                jenkins.pem              jenkins.pem.pub          run.sh
```

