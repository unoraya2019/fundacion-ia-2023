resource "aws_cloudfront_origin_access_identity" "iac" {
  comment = "${var.project}-${var.stage}"
}