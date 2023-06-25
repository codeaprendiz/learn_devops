

## Configuring AWS CLI

```bash
$ aws configure                                
AWS Access Key ID [None]: **********************
AWS Secret Access Key [None]: ************************
Default region name [None]: us-east-1
Default output format [None]: 
```



## Login to ECR, create Repo and Push image

[Link](https://docs.aws.amazon.com/AmazonECR/latest/userguide/getting-started-cli.html)

```bash
$ aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ****************.dkr.ecr.us-east-1.amazonaws.com         
Login Succeeded
```

- Create a repository. After executing this command you can visit the console and check if the 
repository was created.
```bash
aws ecr create-repository \
    --repository-name node-application \
    --image-scanning-configuration scanOnPush=true \
    --region us-east-1
```


- Build a docker image with corresponding tag
```bash
docker build -t *****************.dkr.ecr.us-east-1.amazonaws.com/node-application:latest .
```

- Push the image
```bash
docker push ****************.dkr.ecr.us-east-1.amazonaws.com/node-application:latest
```


## Implementing the changes using terraform

- init

```bash
$ terraform init
```


- plan
```bash
$ terraform plan
Plan: 1 to add, 0 to change, 0 to destroy.

```

- apply
```bash
$ terraform apply
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

myapp-repository-URL = *************.dkr.ecr.us-east-1.amazonaws.com/myapp

```