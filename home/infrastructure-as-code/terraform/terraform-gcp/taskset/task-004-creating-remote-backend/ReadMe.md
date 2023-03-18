# Creating a Remote Backend

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

**High Level Objectives**

- Create a local backend.
- Create a Cloud Storage backend.
- Refresh your Terraform state.

**Skills**

- local backend
- cloud storage backend
- terraform state
- terraform

**Version Stack**

| Stack     | Version |
|-----------|---------|
| Terraform | 1.3.6   |




### Verify Terraform is installed

```bash
terraform --version
```

### Add a local backend

```bash
touch main.tf

## Get project ID
gcloud config list --format 'value(core.project)'
```

- main.tf

```terraform
provider "google" {
  project     = "Project ID"
  region      = "us-central-1"
}
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "Project ID"
  location    = "US"
  uniform_bucket_level_access = true
}
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
```

- Init, Apply

```bash

terraform init

terraform apply

# The Cloud Shell Editor should now display the state file called terraform.tfstate in the terraform/state directory.

# Examine your state file:
terraform show
```

### Add a Cloud Storage backend

- Add cloud storage backend, comment the previous one

```terraform
terraform {
  backend "gcs" {
    bucket  = "Project ID"
    prefix  = "terraform/state"
  }
}
```


- Initialize your backend again. Type yes at the prompt to confirm.

```bash
terraform init -migrate-state
```

- Go the the bucket. Click on your bucket and navigate to the file terraform/state/default.tfstate.

### Refresh the state

- Add labels to the bucket

```bash
terraform refresh
```

### Clean up the workspace

- Uncomment the following part

```terraform
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
```

```bash
terraform init -migrate-state
```

- In the main.tf file, add the force_destroy = true argument to your google_storage_bucket resource. When you delete a bucket, this boolean option will delete all contained objects.
  If you try to delete a bucket that contains objects, Terraform will fail that run.

- Your bucket resource configuration should resemble the following:

```terraform
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "Project ID"
  location    = "US"
  uniform_bucket_level_access = true
  force_destroy = true
}
```


- Apply, destroy

```bash
terraform apply

terraform destroy
```