# Infrastructure as Code with Terraform

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

[Select - Getting Started with Terraform for Google Cloud](https://www.cloudskillsboost.google/paths)

**High Level Objectives**

- Verify Terraform installation
- Define Google Cloud as the provider
- Create, change, and destroy Google Cloud resources by using Terraform

**Skills**
- terraform version
- Provider
- create,change,destroy
- terraform

**Version Stack**

| Stack     | Version |
|-----------|---------|
| Terraform | 1.3.6   |



### Check Terraform Installation

```bash
terraform --version

touch main.tf
```

- main.tf

```terraform
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  region  = "us-central1"
  zone    = "us-central1-c"
}
```

```bash
terraform init
```

- Add the following to main.tf

```terraform
resource "google_compute_instance" "terraform" {
  name         = "terraform"
  machine_type = "n1-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
}
```

```bash
terraform plan
## The configuration fails with the following error. This is because you cannot configure a compute engine without a network.
```

- Now add the network by including the following code segment to the google_compute_instance block.

```terraform
network_interface {
    network = "default"
    access_config {
    }
}
```

```bash
terraform plan

terraform apply
```

- Validate on console

### Change the infrastructure

- Add a tags argument to the instance we just created so that it looks like this:

```terraform
resource "google_compute_instance" "terraform" {
  name         = "terraform"
  machine_type = "n1-standard-2"
  tags         = ["web", "dev"]
  # ...
}
```

```bash
terraform plan

terraform apply
```

- Edit machine type

```terraform
resource "google_compute_instance" "terraform" {
  name         = "terraform"
  machine_type = "n1-standard-1"
  tags         = ["web", "dev"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
  allow_stopping_for_update = true
}
```

```bash
terraform plan

terraform apply
```

- Validate

### Destroy the Infrastructure

```bash
terraform destroy
```