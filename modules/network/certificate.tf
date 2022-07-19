resource "aws_acm_certificate" "iac" {
  domain_name = "*.${var.domain}"
  subject_alternative_names = [
    "*.${var.domain}",
  ]
  validation_method = "DNS"
  tags = {
    "Name" = "${var.domain}"
  }
}