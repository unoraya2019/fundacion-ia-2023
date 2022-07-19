
resource "aws_s3_bucket" "iac" {
  bucket = var.bucket-name
  acl    = "private"
  policy = jsonencode({
    Id      = "iac_cdn_bucket_policy"
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "bucket_policy_site_root"
        Action   = ["s3:ListBucket"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.bucket-name}"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.iac.iam_arn
        }
      },
      {
        Sid      = "bucket_policy_site_all"
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.bucket-name}/*"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.iac.iam_arn
        }
      }
    ]
  })
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  versioning {
    enabled = true
  }
  depends_on = [
    aws_cloudfront_origin_access_identity.iac,
    aws_s3_bucket.iac
  ]
}
