## Objective

1) To assign IAM role to an ec2 instance so that it can upload an object to s3 and download the same.
2) The bucket is private (The object you uploaded should not be accessible publically)
- init
```bash
$ terraform init

```


- plan
```bash
$ terraform plan
Plan: 19 to add, 0 to change, 0 to destroy.
```

- apply
```bash
$ terraform apply
Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

Outputs:

instance = 34.230.47.36
```


- Login to the instance and install
```bash
$ ssh ubuntu@34.230.47.36                          
ubuntu@ip-10-0-1-59:~$ sudo su
root@ip-10-0-1-59:/home/ubuntu# apt update
root@ip-10-0-1-59:/home/ubuntu# apt-get install -y python-pip
root@ip-10-0-1-59:/home/ubuntu# apt-get install -y python-dev
root@ip-10-0-1-59:/home/ubuntu# pip install awscli
```

- Create sample text file and upload to S3
```bash
root@ip-10-0-1-59:/home/ubuntu# echo "this is sample text to be uploaded to S3" > test.txt
```


- Finally, the moment we have been waiting for! Upload an object to S3.
```bash
root@ip-10-0-1-59:/home/ubuntu# aws s3 cp test.txt s3://mybucket-codeaprendiz-26071994/test.txt
upload: ./test.txt to s3://mybucket-codeaprendiz-26071994/test.txt
```



- How is it happening
```bash

root@ip-10-0-1-59:/home/ubuntu# curl http://169.254.169.254/latest/meta-data/iam/security-credentials/s3-mybucket-role
{
  "Code" : "Success",
  "LastUpdated" : "2020-05-22T11:28:17Z",
  "Type" : "AWS-HMAC",
  "AccessKeyId" : "ASIATFSX4L6LIOMILB7H",
  "SecretAccessKey" : "H5gVzrPzH3L1Cv8NBGEgdEOFqxAjOEYm0y5vrEia",
  "Token" : "IQ8************VjEOz//////////wEaCXVzLWVhc3QtMSJIME4ieN40Ha************************==",
  "Expiration" : "2020-05-22T17:49:20Z"
}
```


- Now download the file from s3 and see the contents
```bash
ubuntu@ip-10-0-1-59:~$ aws s3 cp s3://mybucket-codeaprendiz-26071994/test.txt newfile.txt
download: s3://mybucket-codeaprendiz-26071994/test.txt to ./newfile.txt
ubuntu@ip-10-0-1-59:~$ cat ./newfile.txt 
this is sample text to be uploaded to S3
```

- Note, you have not be able to access this file via public internet because the bucket is private.


- destroy. You will need to empty the bucket via console for terraform destroy to work on s3 as well. 
```bash
$ terraform destroy
Destroy complete! Resources: 19 destroyed.

```
