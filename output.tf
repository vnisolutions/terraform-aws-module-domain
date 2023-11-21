output "zone_id" {
  value = aws_route53_zone.route53_zone.zone_id
}

output "acm_certificate" {
  value = module.acm[0].acm_certificate
}

output "acm_certificate_global" {
  value = module.acm[0].acm_certificate_global
}
