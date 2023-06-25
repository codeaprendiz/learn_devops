

/*
 * Terraform compute resources for GCP.
 * Acquire all zones and choose one randomly.
 */

data "google_compute_zones" "available" {
  region = var.gcp_region
}

resource "google_compute_address" "gcp-ip" {
  name   = "gcp-vm-ip-${var.gcp_region}"
  region = var.gcp_region
}

resource "google_compute_instance" "gcp-vm" {
  name         = "gcp-vm-${var.gcp_region}"
  machine_type = var.gcp_instance_type
  zone         = data.google_compute_zones.available.names[0]

  boot_disk {
    initialize_params {
      image = var.gcp_disk_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.gcp-subnet1.name
    network_ip = var.gcp_vm_address

    access_config {
      # Static IP
      nat_ip = google_compute_address.gcp-ip.address
    }
  }

  # Cannot pre-load both gcp and aws since that creates a circular dependency.
  # Can pre-populate the AWS IPs to make it easier to run tests.
  metadata_startup_script = replace(
    replace(file("vm_userdata.sh"), "<EXT_IP>", aws_eip.aws-ip.public_ip),
    "<INT_IP>",
    var.aws_vm_address,
  )
}

