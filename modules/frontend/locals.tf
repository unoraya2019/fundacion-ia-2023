locals {
  s3_origin_id  = "S3-${var.bucket-name}"
  origin_id_alb = var.dns_alb
}