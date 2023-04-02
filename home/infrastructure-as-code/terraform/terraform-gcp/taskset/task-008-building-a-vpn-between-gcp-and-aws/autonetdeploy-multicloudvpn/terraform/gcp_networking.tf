
/*
 * Terraform networking resources for GCP.
 * Updated by Sureskills/Kogneos 21/04/2022
 */

resource "google_compute_network" "gcp-network" {
  name                    = "gcp-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "gcp-subnet1" {
  name          = "gcp-subnet1"
  ip_cidr_range = var.gcp_subnet1_cidr
  network       = google_compute_network.gcp-network.name
  region        = var.gcp_region
}

/*
 * ----------VPN Connection----------
 */

resource "google_compute_ha_vpn_gateway" "gcp-vpn-gw" {
  name    = "gcp-vpn-gw-${var.gcp_region}"
  network = google_compute_network.gcp-network.name
  region  = var.gcp_region
}

resource "google_compute_external_vpn_gateway" "external_gateway" {
  name            = "aws-gateway"
  redundancy_type = "FOUR_IPS_REDUNDANCY"
  description     = "Dual AWS VPN gateways"
  interface {
    id         = 0
    ip_address = aws_vpn_connection.aws-vpn-connection1.tunnel1_address
  }
  interface {
    id         = 1
    ip_address = aws_vpn_connection.aws-vpn-connection1.tunnel2_address
  }
  interface {
    id         = 2
    ip_address = aws_vpn_connection.aws-vpn-connection2.tunnel1_address
  }
  interface {
    id         = 3
    ip_address = aws_vpn_connection.aws-vpn-connection2.tunnel2_address
  }  
}


 /* ----------VPN Tunnel1----------
 */
resource "google_compute_vpn_tunnel" "gcp-tunnel1" {
  name                            = "gcp-tunnel1"
  peer_external_gateway           = google_compute_external_vpn_gateway.external_gateway.id
  peer_external_gateway_interface = 0
  shared_secret                   = aws_vpn_connection.aws-vpn-connection1.tunnel1_preshared_key
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-vpn-gw.self_link
  router                          = google_compute_router.gcp-router1.name
  vpn_gateway_interface           = 0
}

resource "google_compute_router" "gcp-router1" {
  name    = "gcp-router1"
  region  = var.gcp_region
  network = google_compute_network.gcp-network.name
  bgp {
    asn = aws_customer_gateway.aws-cgw-1.bgp_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_router_peer" "gcp-router1-peer" {
  name            = "gcp-to-aws-bgp1"
  router          = google_compute_router.gcp-router1.name
  region          = google_compute_router.gcp-router1.region
  peer_ip_address = aws_vpn_connection.aws-vpn-connection1.tunnel1_vgw_inside_address
  peer_asn        = var.GCP_TUN1_VPN_GW_ASN
  interface       = google_compute_router_interface.router_interface1.name
}

resource "google_compute_router_interface" "router_interface1" {
  name       = "gcp-to-aws-interface1"
  router     = google_compute_router.gcp-router1.name
  region     = google_compute_router.gcp-router1.region
  ip_range   = "${aws_vpn_connection.aws-vpn-connection1.tunnel1_cgw_inside_address}/${var.GCP_TUN1_CUSTOMER_GW_INSIDE_NETWORK_CIDR}"
  vpn_tunnel = google_compute_vpn_tunnel.gcp-tunnel1.name
}

 /* ----------VPN Tunnel2----------
 */
resource "google_compute_vpn_tunnel" "gcp-tunnel2" {
  name                            = "gcp-tunnel2"
  peer_external_gateway           = google_compute_external_vpn_gateway.external_gateway.id
  peer_external_gateway_interface = 1
  shared_secret                   = aws_vpn_connection.aws-vpn-connection1.tunnel2_preshared_key
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-vpn-gw.self_link
  router                          = google_compute_router.gcp-router2.name
  vpn_gateway_interface           = 0
}

resource "google_compute_router" "gcp-router2" {
  name    = "gcp-router2"
  region  = var.gcp_region
  network = google_compute_network.gcp-network.name
  bgp {
    asn = aws_customer_gateway.aws-cgw-1.bgp_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_router_peer" "gcp-router2-peer" {
  name            = "gcp-to-aws-bgp2"
  router          = google_compute_router.gcp-router2.name
  region          = google_compute_router.gcp-router2.region
  peer_ip_address = aws_vpn_connection.aws-vpn-connection1.tunnel2_vgw_inside_address
  peer_asn        = var.GCP_TUN2_VPN_GW_ASN
  interface       = google_compute_router_interface.router_interface2.name
}

resource "google_compute_router_interface" "router_interface2" {
  name       = "gcp-to-aws-interface2"
  router     = google_compute_router.gcp-router2.name
  region     = google_compute_router.gcp-router2.region
  ip_range   = "${aws_vpn_connection.aws-vpn-connection1.tunnel2_cgw_inside_address}/${var.GCP_TUN2_CUSTOMER_GW_INSIDE_NETWORK_CIDR}"
  vpn_tunnel = google_compute_vpn_tunnel.gcp-tunnel2.name
}

 /* ----------VPN Tunnel3----------
 */
resource "google_compute_vpn_tunnel" "gcp-tunnel3" {
  name                            = "gcp-tunnel3"
  peer_external_gateway           = google_compute_external_vpn_gateway.external_gateway.id
  peer_external_gateway_interface = 2
  shared_secret                   = aws_vpn_connection.aws-vpn-connection2.tunnel1_preshared_key
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-vpn-gw.self_link
  router                          = google_compute_router.gcp-router3.name
  vpn_gateway_interface           = 1
}

resource "google_compute_router" "gcp-router3" {
  name    = "gcp-router3"
  region  = var.gcp_region
  network = google_compute_network.gcp-network.name
  bgp {
    asn = aws_customer_gateway.aws-cgw-2.bgp_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_router_peer" "gcp-router3-peer" {
  name            = "gcp-to-aws-bgp3"
  router          = google_compute_router.gcp-router3.name
  region          = google_compute_router.gcp-router3.region
  peer_ip_address = aws_vpn_connection.aws-vpn-connection2.tunnel1_vgw_inside_address
  peer_asn        = var.GCP_TUN1_VPN_GW_ASN
  interface       = google_compute_router_interface.router_interface3.name
}

resource "google_compute_router_interface" "router_interface3" {
  name       = "gcp-to-aws-interface3"
  router     = google_compute_router.gcp-router3.name
  region     = google_compute_router.gcp-router3.region
  ip_range   = "${aws_vpn_connection.aws-vpn-connection2.tunnel1_cgw_inside_address}/${var.GCP_TUN1_CUSTOMER_GW_INSIDE_NETWORK_CIDR}"
  vpn_tunnel = google_compute_vpn_tunnel.gcp-tunnel3.name
}

/* ----------VPN Tunnel4----------
 */
resource "google_compute_vpn_tunnel" "gcp-tunnel4" {
  name                            = "gcp-tunnel4"
  peer_external_gateway           = google_compute_external_vpn_gateway.external_gateway.id
  peer_external_gateway_interface = 3
  shared_secret                   = aws_vpn_connection.aws-vpn-connection2.tunnel2_preshared_key
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-vpn-gw.self_link
  router                          = google_compute_router.gcp-router4.name
  vpn_gateway_interface           = 1
}

resource "google_compute_router" "gcp-router4" {
  name    = "gcp-router4"
  region  = var.gcp_region
  network = google_compute_network.gcp-network.name
  bgp {
    asn = aws_customer_gateway.aws-cgw-2.bgp_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_router_peer" "gcp-router4-peer" {
  name            = "gcp-to-aws-bgp4"
  router          = google_compute_router.gcp-router4.name
  region          = google_compute_router.gcp-router4.region
  peer_ip_address = aws_vpn_connection.aws-vpn-connection2.tunnel2_vgw_inside_address
  peer_asn        = var.GCP_TUN2_VPN_GW_ASN
  interface       = google_compute_router_interface.router_interface4.name
}

resource "google_compute_router_interface" "router_interface4" {
  name       = "gcp-to-aws-interface4"
  router     = google_compute_router.gcp-router4.name
  region     = google_compute_router.gcp-router4.region
  ip_range   = "${aws_vpn_connection.aws-vpn-connection2.tunnel2_cgw_inside_address}/${var.GCP_TUN2_CUSTOMER_GW_INSIDE_NETWORK_CIDR}"
  vpn_tunnel = google_compute_vpn_tunnel.gcp-tunnel4.name
}