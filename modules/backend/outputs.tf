output "dns_alb" {
  value = aws_lb.iac.dns_name
}

output "repository_url" {
  value = aws_ecr_repository.iac.repository_url
}