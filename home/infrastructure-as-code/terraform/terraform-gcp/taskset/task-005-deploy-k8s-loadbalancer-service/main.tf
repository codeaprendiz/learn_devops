# Variables are defined for region, zone, and network_name. These will be used to create the Kubernetes cluster

variable "region" {
  type        = string
  description = "Region for the resource."
}

variable "location" {
  type        = string
  description = "Location represents region/zone for the resource."
}

variable  "network_name" {
  default = "tf-gke-k8s"
}

# The Google Cloud provider will let us create resources in the project.
provider "google" {
  region = var.region
}

# creates a new network with the specified name.
resource "google_compute_network" "default" {
  name                    = var.network_name
  #  is set to false, which means that we'll create subnets explicitly.
  auto_create_subnetworks = false
}

# creates a subnet with the specified ip_cidr_range and associates it with the network created in the previous step.
resource "google_compute_subnetwork" "default" {
  name                     = var.network_name
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.default.self_link
  region                   = var.region
  # private_ip_google_access is set to true, which means that VMs in the subnet can reach Google API endpoints using their private IP addresses.
  private_ip_google_access = true
}

# retrieves the access token for the current Google Cloud user, which is used for authentication when creating the Kubernetes cluster.
data "google_client_config" "current" {
}

# retrieves the list of available Kubernetes versions for the specified location.
data "google_container_engine_versions" "default" {
  location = var.location
}

# creates a new Kubernetes cluster with the specified name, location, and initial node count.
# min_master_version is set to the latest available version of Kubernetes.
# network and subnetwork are set to the name of the subnet created earlier.
# enable_legacy_abac is set to true to use ABAC authorization.
# Finally, the provisioner block waits for 90 seconds after deleting the cluster to give the
# GCE LB controller time to clean up resources.
resource "google_container_cluster" "default" {
  name               = var.network_name
  location           = var.location
  initial_node_count = 3
  min_master_version = data.google_container_engine_versions.default.latest_master_version
  network            = google_compute_subnetwork.default.name
  subnetwork         = google_compute_subnetwork.default.name

  // Use legacy ABAC until these issues are resolved: 
  //   https://github.com/mcuadros/terraform-provider-helm/issues/56
  //   https://github.com/terraform-providers/terraform-provider-kubernetes/pull/73
  enable_legacy_abac = true

  // Wait for the GCE LB controller to cleanup the resources.
  // Wait for the GCE LB controller to cleanup the resources.
  provisioner "local-exec" {
    when    = destroy
    command = "sleep 90"
  }
}

output "network" {
  value = google_compute_subnetwork.default.network
}

output "subnetwork_name" {
  value = google_compute_subnetwork.default.name
}

output "cluster_name" {
  value = google_container_cluster.default.name
}

output "cluster_region" {
  value = var.region
}

output "cluster_location" {
  value = google_container_cluster.default.location
}

