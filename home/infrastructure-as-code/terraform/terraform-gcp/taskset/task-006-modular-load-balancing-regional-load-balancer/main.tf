/*
The "locals" block defines a variable named "health_check_port" that is set to the value of "var.health_check["port"]".
*/
locals {
  health_check_port = var.health_check["port"]
}

/*
In GCP, a forwarding rule is a configuration that specifies how traffic should be directed to a load balancer.
A forwarding rule specifies the IP address, protocol, and ports that the load balancer should listen on.
It also defines the target pool, which is a group of backend instances that the load balancer will direct traffic to.

The "google_compute_forwarding_rule" resource creates a forwarding rule to route traffic to the target pool. 
It specifies the provider, project, name, target, load balancing scheme, port range, region, IP address, IP protocol, and labels.

Forwarding rule has an associated target pool


Created for 
- basic-load_balancer_default
- basic-load_balancer_custom_hc
- basic-load_balancer_no_hc
*/

resource "google_compute_forwarding_rule" "default" {
  provider              = google-beta
  project               = var.project
  name                  = var.name
  target                = google_compute_target_pool.default.self_link
  load_balancing_scheme = "EXTERNAL"
  port_range            = var.service_port
  region                = var.region
  ip_address            = var.ip_address
  ip_protocol           = var.ip_protocol
  labels                = var.labels
}

/*
In Google Cloud Platform (GCP), a target pool is a group of virtual machine (VM) instances or internet protocol 
(IP) addresses that 
receive incoming traffic from a Google Cloud load balancer. The target pool defines the set of virtual machines or 
IP addresses 
that should receive traffic, and the load balancer routes traffic to the instances in the pool based on the 
load balancing algorithm configured for the load balancer.

The "google_compute_target_pool" resource creates a target pool to distribute traffic across instances. 
It specifies the project, name, region, and session affinity.

The "health_checks" attribute is set to an empty list if "var.disable_health_check" is true, otherwise 
it includes a reference to the HTTP health check resource

Created for
- basic-load-balancer-default: creates healthcheck : basic-load-balancer-default-hc : Path /, port 80
- basic-load-balancer-custom-hc : creates healthcheck : basic-load-balancer-custom-hc : Host 1.2.3.4 and path 
  is /mypath, port 8080
- basic-load_balancer_no_hc : "health_checks" attribute is set to an empty list : So health check will be set to NONE

Target Pools are associated with healthchecks.

*/
resource "google_compute_target_pool" "default" {
  project          = var.project
  name             = var.name
  region           = var.region
  session_affinity = var.session_affinity

  health_checks = var.disable_health_check ? [] : [google_compute_http_health_check.default[0].self_link]
}

/*
The "google_compute_http_health_check" resource creates an HTTP health check to verify the health of instances. 
It specifies the project, name, check interval, healthy threshold, timeout, unhealthy threshold, port, request path, 
and host.

The count parameter is used to conditionally create the resource depending on the value of the disable_health_check 
variable. 
If disable_health_check is set to true, the health check resource will not be created.

Health check is used by a Target Pool

Created for 
- basic-load_balancer_default
- basic-load_balancer_custom_hc

Not created for
- basic-load_balancer_no_hc
*/
resource "google_compute_http_health_check" "default" {
  count   = var.disable_health_check ? 0 : 1
  project = var.project
  name    = "${var.name}-hc"

  check_interval_sec  = var.health_check["check_interval_sec"]
  healthy_threshold   = var.health_check["healthy_threshold"]
  timeout_sec         = var.health_check["timeout_sec"]
  unhealthy_threshold = var.health_check["unhealthy_threshold"]

  port         = local.health_check_port == null ? var.service_port : local.health_check_port
  request_path = var.health_check["request_path"]
  host         = var.health_check["host"]
}

/*
In Google Cloud Platform (GCP), firewall rules are used to control network traffic to and from virtual machine instances. 
They act as a barrier between your instances and the internet or other networks, allowing you 
to specify what kind of traffic is allowed or blocked.

The "google_compute_firewall" resources create firewall rules to control network traffic. 
The first firewall ("default-lb-fw") allows traffic on the specified protocol and port, from the specified source ranges, 
to instances with the specified target tags and service accounts. 

Created with names 
- basic-load-balancer-custom-hc-vm-service 
- basic-load-balancer-default-vm-service
- basic-load-balancer-no-hc-vm-service

*/
resource "google_compute_firewall" "default-lb-fw" {
  project = var.firewall_project == "" ? var.project : var.firewall_project
  name    = "${var.name}-vm-service"
  network = var.network

  allow {
    protocol = lower(var.ip_protocol)
    ports    = [var.service_port]
  }

  source_ranges = var.allowed_ips

  target_tags = var.target_tags

  target_service_accounts = var.target_service_accounts
}

/*
The second firewall ("default-hc-fw") allows TCP traffic on the health check port, from specified source ranges, 
to instances with the specified target tags and service accounts. 
The count attribute is used to conditionally create this resource based on whether health checks are disabled or not.

Created with name
- basic-load-balancer-custom-hc-hc
- basic-load-balancer-default-hc

Created for 
- basic-load-balancer-custom-hc
- basic-load-balancer-default

Not Created for
- basic-load-balancer-no-hc
*/
resource "google_compute_firewall" "default-hc-fw" {
  count   = var.disable_health_check ? 0 : 1
  project = var.firewall_project == "" ? var.project : var.firewall_project
  name    = "${var.name}-hc"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = [local.health_check_port == null ? 80 : local.health_check_port]
  }

  source_ranges = ["35.191.0.0/16", "209.85.152.0/22", "209.85.204.0/22"]

  target_tags = var.target_tags

  target_service_accounts = var.target_service_accounts
}
