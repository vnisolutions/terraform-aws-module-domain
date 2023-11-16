resource "aws_route53_zone" "route53_zone" {
  name    = var.domain
  comment = "Hostzone ${var.domain}"
}

module "acm" {
  count  = var.create_acm ? 1 : 0
  source = "./modules/acm"
  providers = {
    aws.global = aws.global
  }
  domain  = var.domain
  zone_id = aws_route53_zone.route53_zone.zone_id
}

module "ses" {
  count     = var.create_ses ? 1 : 0
  source    = "./modules/ses"
  domain    = var.domain
  zone_id   = aws_route53_zone.route53_zone.zone_id
  zone_name = aws_route53_zone.route53_zone.name
}
