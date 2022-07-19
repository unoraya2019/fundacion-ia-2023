resource "aws_cloudfront_distribution" "iac" {

  # Origin to Statics Files
  origin {
    domain_name = aws_s3_bucket.iac.bucket_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.iac.cloudfront_access_identity_path
    }
  }
  # Default index

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.project}-${var.stage}"
  default_root_object = "index.html"

  # if there is a 404, return index.html witch a HTTP 200 Responde
  custom_error_response {
    error_caching_min_ttl = 3000
    error_code            = 404
    response_code         = 200
    response_page_path    = "/"
  }


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    viewer_protocol_policy = "allow-all"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_All" # Use All Edge Locations (Best Performance)

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "JP", "AF", "AL", "CU", "RU"]
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
  depends_on = [
    aws_s3_bucket.iac,
    aws_cloudfront_origin_access_identity.iac
  ]
}
