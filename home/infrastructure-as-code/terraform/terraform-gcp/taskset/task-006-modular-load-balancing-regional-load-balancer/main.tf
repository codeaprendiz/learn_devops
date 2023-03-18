locals {
  health_check_port = var.health_check["port"]
}

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

resource "google_compute_target_pool" "default" {
  project          = var.project
  name             = var.name
  region           = var.region
  session_affinity = var.session_affinity

  health_checks = var.disable_health_check ? [] : [google_compute_http_health_check.default[0].self_link]
}

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
