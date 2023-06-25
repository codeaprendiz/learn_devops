# Creating Resource Dependencies with Terraform

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

**High Level Objectives**

- Use variables and output values
- Observe implicit dependency
- Create explicit resource dependency
- View Dependency Graph

**Skills**

- variables
- output values
- explicit resource dependency
- dependency graph
- terraform

**Version Stack**

| Stack     | Version |
|-----------|---------|
| Terraform | 1.3.6   |




### Initialize Terraform

```bash
terraform -version

# Create a directory for your Terraform configuration and navigate to it by running the following command:
mkdir tfinfra && cd $_

touch provider.tf
```

- provider.tf

```bash
# Get project ID
gcloud config list --format 'value(core.project)'
```

```terraform
  provider "google" {
  project = "<your-project-id>"
  region  = "us-east1"
  zone    = "us-east1-b"
}
```

- Initialize

```bash
terraform init
```

### View Implicit Resource Dependency

```bash
touch instance.tf
```

- instance.tf

```bash
resource google_compute_instance "vm_instance" {
name         = "${var.instance_name}"
zone         = "${var.instance_zone}"
machine_type = "${var.instance_type}"
boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      }
  }
 network_interface {
    network = "default"
    access_config {
      # Allocate a one-to-one NAT IP to the instance
    }
  }
}
```

```bash
touch variables.tf
```

- variables.tf
```terraform
variable "instance_name" {
  type        = string
  description = "Name for the Google Compute instance"
}
variable "instance_zone" {
  type        = string
  description = "Zone for the Google Compute instance"
}
variable "instance_type" {
  type        = string
  description = "Disk type of the Google Compute instance"
  default     = "n1-standard-1"
  }
```

```bash
touch outputs.tf
```

- outputs.tf

```terraform
output "network_IP" {
  value = google_compute_instance.vm_instance.instance_id
  description = "The internal ip address of the instance"
}
output "instance_link" {
  value = google_compute_instance.vm_instance.self_link
  description = "The URI of the created resource."
}
```

- Let's assign static IP to VM instance

- Append to instance.tf
```terraform
resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}
```
- Update the network_interface configuration for your instance like so:

```terraform
 network_interface {
    network = "default"
    access_config {
      # Allocate a one-to-one NAT IP to the instance
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
```

- Init, Plan, Apply

```bash
terraform init

# var.instance_name: myinstance
# var.instance_zone: us-east1-b
terraform plan

# var.instance_name: myinstance
# var.instance_zone: us-east1-b
terraform apply
```

- Verify on Cloud Console

### Create Explicit Dependency

```bash
touch exp.tf
```

- exp.tf

```terraform
resource "google_compute_instance" "another_instance" {
  name         = "terraform-instance-2"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
  # Tells Terraform that this VM instance must be created only after the
  # storage bucket has been created.
  depends_on = [google_storage_bucket.example_bucket]
}
resource "google_storage_bucket" "example_bucket" {
  name     = "<UNIQUE-BUCKET-NAME>"
  location = "US"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
```


- Init, Plan, Apply

```bash
terraform init

# var.instance_name: myinstance
# var.instance_zone: us-east1-b
terraform plan

# var.instance_name: myinstance
# var.instance_zone: us-east1-b
terraform apply
```

- Validate on console


### View Dependency Graph

```bash
terraform graph | dot -Tsvg > graph.svg
```

