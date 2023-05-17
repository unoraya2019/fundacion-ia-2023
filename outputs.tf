output "DNS_Alb" {
  value = module.backend.dns_alb
}

/*output "DB_Endpoint" {
  value = module.database.db_endpoint
}*/

output "DB_Endpoint_postgresql" {
  value = module.database.db_endpoint_postgrest
}

output "Cloudfront_S3" {
  value = module.frontend.domain_name
}

output "Repository_url" {
  value = module.backend.repository_url
}