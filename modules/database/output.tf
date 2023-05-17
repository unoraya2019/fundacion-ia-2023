/*output "db_endpoint" {
  value = aws_rds_cluster.iac_mysql.endpoint
}*/

output "db_endpoint_postgrest" {
  value = aws_rds_cluster.iac.endpoint
}
