//------ [ E-Mail Enable ] ---------------------------------------------------------
resource "aws_ses_domain_identity" "ses_domain_identity" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  domain = aws_ses_domain_identity.ses_domain_identity.domain
}

resource "aws_route53_record" "route53_record_ses" {
  name    = "_amazonses.${var.zone_name}"
  type    = "TXT"
  ttl     = "600"
  zone_id = var.zone_id
  records = [
    aws_ses_domain_identity.ses_domain_identity.verification_token
  ]
}

resource "aws_route53_record" "route53_record_dkim" {
  count   = 3
  name    = "${aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  zone_id = var.zone_id
  records = ["${aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens[count.index]}.dkim.amazonses.com"]
}
