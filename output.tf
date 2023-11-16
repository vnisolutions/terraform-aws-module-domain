output "zone_id" {
  value = aws_route53_zone.route53_zone.zone_id
}

output "acm_certificate" {
  value = try(module.acm.acm_certificate[*], null)
}

output "acm_certificate_global" {
  value = try(module.acm.acm_certificate_global[*], null)
}
