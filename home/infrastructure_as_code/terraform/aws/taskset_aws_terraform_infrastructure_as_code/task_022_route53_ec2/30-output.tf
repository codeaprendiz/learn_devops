output "devopslink-public-zone-id" {
  value = aws_route53_zone.devopslink-public-zone.zone_id
}

output "devopslink-name-servers" {
  value = aws_route53_zone.devopslink-public-zone.name_servers
}


