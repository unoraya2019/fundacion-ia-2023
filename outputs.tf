output "DNS_Alb" {
  value = module.backend.dns_alb
}

output "DB_Endpoint" {
  value = module.database.db_endpoint
}

output "Cloudfront_S3" {
  value = module.frontend.domain_name
}

output "repository_url" {
  value = module.backend.repository_url
}