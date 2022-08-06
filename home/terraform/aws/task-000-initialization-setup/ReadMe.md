# Initialization Setup

- Create a user `terraform` by navigating _Login to AWS_ ->  _IAM_ -> _Users_ -> _Add User_

![](../../../images/terraform/aws/task-000-initialization-setup/Add_user_screen.png)

- Create a group `terraform-administrators`

![](../../../images/terraform/aws/task-000-initialization-setup/group_creation_screen.png)

- Review screen

![](../../../images/terraform/aws/task-000-initialization-setup/review_screen.png)

- Download the `credentials.csv` containing `Access key ID` and `Secret access key`

- These values can be used in the following ways

    1) Export the values of `Access key ID` and `Secret access key` as showing below in your 
       current shell.
        
        ```bash
        export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
        export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY
        ```
        
        - Now you can run the `terrform` commands in the same shell session.
        
     2) Add these values to the file `terraform.tfvars` in project directory DEFINATELY ADD IT TO `.gitignore` 
        file. NEVER NEVER NEVER commit `terraform.tfvars` this file to git repository (as it contains you access
        key id and secret access key)
        
        ```bash
        $ cat terraform.tfvars           
        AWS_ACCESS_KEY = "YOUR_ACCESS_KEY_ID"
        AWS_SECRET_KEY = "YOUR_SECRET_ACCESS_KEY"      
        ```
        
        - Now while running `terraform` commands you will have to pass this file as argument at the end like 
        shown below
        ```bash
        $ terraform apply -var-file=../../terraform.tfvars
        ```
        
        
# Configuring AWS CLI

```bash
$ aws configure                                
AWS Access Key ID [None]: **********************
AWS Secret Access Key [None]: ************************
Default region name [None]: us-east-1
Default output format [None]: 
```