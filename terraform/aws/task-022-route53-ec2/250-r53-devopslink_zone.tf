###_____   ___    _   _   _____
##|__  /  / _ \  | \ | | | ____|
####/ /  | | | | |  \| | |  _|
###/ /_  | |_| | | |\  | | |___
##/____|  \___/  |_| \_| |_____|

resource "aws_route53_zone" "devopslink-public-zone" {
  name = var.domain_mydevops_link
  comment = "${var.domain_mydevops_link} public zone"
  provider = aws
}