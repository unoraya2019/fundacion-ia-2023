# DB Aurora Mysql
resource "aws_rds_cluster_instance" "cluster_instances_1" {
  identifier         = "${var.name}-1"
  cluster_identifier = aws_rds_cluster.iac.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.iac.engine
  engine_version     = aws_rds_cluster.iac.engine_version
}

resource "aws_rds_cluster_instance" "cluster_instances_2" {
  identifier         = "${var.name}-2"
  cluster_identifier = aws_rds_cluster.iac.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.iac.engine
  engine_version     = aws_rds_cluster.iac.engine_version
}

resource "aws_rds_cluster" "iac" {
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
  backtrack_window                = 0
  backup_retention_period         = 7
  cluster_identifier              = var.name
  copy_tags_to_snapshot           = true
  db_cluster_parameter_group_name = var.db_parameter_group_name
  db_subnet_group_name            = aws_db_subnet_group.production.name
  deletion_protection             = false
  enable_http_endpoint            = false
  enabled_cloudwatch_logs_exports = [
    "error",
    "general",
  ]
  engine                       = var.db_engine
  engine_version               = var.db_engine_version
  master_username              = var.db_username
  master_password              = var.db_password
  database_name                = var.db_name
  port                         = var.db_port
  preferred_backup_window      = "06:35-07:05"
  preferred_maintenance_window = "fri:07:47-fri:08:17"
  vpc_security_group_ids       = var.vpc_security_group_ids
}