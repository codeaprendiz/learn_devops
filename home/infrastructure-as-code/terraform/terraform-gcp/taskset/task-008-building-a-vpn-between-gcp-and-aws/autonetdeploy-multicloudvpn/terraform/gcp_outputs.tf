

/*
 * Terraform output variables for GCP.
 */

output "gcp_instance_external_ip" {
  value = <<-EOF
  ${google_compute_instance.gcp-vm.network_interface[0].access_config[0].nat_ip}
EOF

}

output "gcp_instance_internal_ip" {
  value = google_compute_instance.gcp-vm.network_interface[0].network_ip
}

