output "network_IP" {
  value = google_compute_instance.vm_instance.instance_id
  description = "The internal ip address of the instance"
}
output "instance_link" {
  value = google_compute_instance.vm_instance.self_link
  description = "The URI of the created resource."
}