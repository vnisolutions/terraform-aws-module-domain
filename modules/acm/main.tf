resource "aws_acm_certificate" "acm_certificate" {
  validation_method = "DNS"
  domain_name       = var.domain
  subject_alternative_names = [
    "*.${var.domain}"
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "acm_certificate_global" {
  provider          = aws.global
  validation_method = "DNS"
  domain_name       = var.domain
  subject_alternative_names = [
    "*.${var.domain}"
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "route53_record_acm" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  zone_id         = var.zone_id
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  ttl             = 60
  allow_overwrite = true
}
