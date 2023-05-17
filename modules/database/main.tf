# DB Aurora postgresql
resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = 1
  identifier         = "${var.name}-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.iac.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.iac.engine
  engine_version     = aws_rds_cluster.iac.engine_version
}

resource "aws_rds_cluster" "iac" {
  cluster_identifier = var.name
  engine             = var.db_engine
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1d"
  ]
  database_name           = var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  backup_retention_period = 7
  preferred_backup_window = "06:35-07:05"
  backtrack_window        = 0
  db_subnet_group_name = aws_db_subnet_group.production.name
  deletion_protection  = false
  enable_http_endpoint = false
  engine_version               = var.db_engine_version  
  port                         = "5432"
  preferred_maintenance_window = "fri:07:47-fri:08:17"
  vpc_security_group_ids       = var.vpc_security_group_ids
  final_snapshot_identifier    = "ci-aurora-cluster-backup"
  skip_final_snapshot          = true
}
