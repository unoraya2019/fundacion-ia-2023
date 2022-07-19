resource "aws_db_subnet_group" "production" {
  name        = "${var.project}-subnet-group-production"
  description = "${var.project}-subnet-group-production"
  subnet_ids = [
    var.subnet-production-dcp,
    var.subnet-production-dca
  ]
  tags = {
    "Name" = "Subnet Group Production DB"
  }
}
