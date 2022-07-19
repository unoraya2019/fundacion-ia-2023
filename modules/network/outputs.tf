output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.iac.id
}
output "sg_rds_prod" {
  description = "ID Security Group RDS"
  value       = aws_security_group.sg_rds_prod.id
}
output "sg_alb" {
  description = "ID Security Group ALB"
  value       = aws_security_group.sg_alb.id
}
output "sg_ec2" {
  description = "ID Security Group EC2"
  value       = aws_security_group.sg_ec2.id
}
output "certificate_arn" {
  value = aws_acm_certificate.iac.arn
}
output "subnet_wordpress_a" {
  value = aws_subnet.wordpress_a.id
}
output "subnet_wordpress_b" {
  value = aws_subnet.wordpress_b.id
}
output "subnet_databases_prod_a" {
  value = aws_subnet.databases_prod_a.id
}
output "subnet_databases_prod_b" {
  value = aws_subnet.databases_prod_b.id
}
output "zone_id" {
  value = aws_route53_zone.iac.id
}