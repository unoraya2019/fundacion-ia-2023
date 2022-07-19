output "domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = aws_cloudfront_distribution.iac.domain_name
}
