output "acm_certificate" {
  value = aws_acm_certificate.acm_certificate.arn
}

output "acm_certificate_global" {
  value = aws_acm_certificate.acm_certificate_global.arn
}