resource "aws_route53_record" "server1-record" {
  zone_id = aws_route53_zone.devopslink-public-zone.zone_id
  name    = "server1.codeaprendiz.tk"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]
}



