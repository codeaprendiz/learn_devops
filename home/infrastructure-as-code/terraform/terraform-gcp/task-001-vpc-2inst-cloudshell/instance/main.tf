resource "google_compute_instance" "vm_instance" {
  name = var.instance_name
  # RESOURCE properties go here
  zone         = var.instance_zone
  machine_type = var.instance_type
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      }
  }
    network_interface {
    network = var.instance_network
    access_config {
      # Allocate a one-to-one NAT IP to the instance
    }
  }
}