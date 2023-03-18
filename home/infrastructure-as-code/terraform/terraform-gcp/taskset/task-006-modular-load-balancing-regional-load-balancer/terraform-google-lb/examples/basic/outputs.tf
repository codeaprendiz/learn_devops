output "load_balancer_default_ip" {
  description = "The external ip address of the forwarding rule for default lb."
  value       = module.load_balancer_default.external_ip
}
