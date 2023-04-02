

/*
 * Terraform networking resources for AWS.
 */

resource "aws_vpc" "aws-vpc" {
  cidr_block           = var.aws_network_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "aws-vpc"
  }
}

resource "aws_subnet" "aws-subnet1" {
  vpc_id     = aws_vpc.aws-vpc.id
  cidr_block = var.aws_subnet1_cidr

  tags = {
    Name = "aws-vpn-subnet"
  }
}

resource "aws_internet_gateway" "aws-vpc-igw" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    Name = "aws-vpc-igw"
  }
}

/*
 * ----------VPN Connection----------
 */

resource "aws_vpn_gateway" "aws-vpn-gw" {
  vpc_id = aws_vpc.aws-vpc.id
}

resource "aws_customer_gateway" "aws-cgw-1" {
  bgp_asn    = 65000
  ip_address = google_compute_ha_vpn_gateway.gcp-vpn-gw.vpn_interfaces[0].ip_address
  type       = "ipsec.1"
  tags = {
    "Name" = "aws-customer-gw"
  }
}
resource "aws_customer_gateway" "aws-cgw-2" {
  bgp_asn    = 65000
  ip_address = google_compute_ha_vpn_gateway.gcp-vpn-gw.vpn_interfaces[1].ip_address
  type       = "ipsec.1"
  tags = {
    "Name" = "aws-customer-gw"
  }
}

resource "aws_default_route_table" "aws-vpc" {
  default_route_table_id = aws_vpc.aws-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-vpc-igw.id
  }
  propagating_vgws = [
    aws_vpn_gateway.aws-vpn-gw.id,
  ]
}

resource "aws_vpn_connection" "aws-vpn-connection1" {
  vpn_gateway_id      = aws_vpn_gateway.aws-vpn-gw.id
  customer_gateway_id = aws_customer_gateway.aws-cgw-1.id
  type                = "ipsec.1"
  static_routes_only  = false
  tags = {
    "Name" = "aws-vpn-connection1"
  }
}

resource "aws_vpn_connection" "aws-vpn-connection2" {
  vpn_gateway_id      = aws_vpn_gateway.aws-vpn-gw.id
  customer_gateway_id = aws_customer_gateway.aws-cgw-2.id
  type                = "ipsec.1"
  static_routes_only  = false
  tags = {
    "Name" = "aws-vpn-connection2"
  }
}


