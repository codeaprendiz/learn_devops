resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}
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
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
}