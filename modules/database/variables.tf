variable "project" {
  description = "Name Project"
}
variable "subnet-production-dcp" {
  description = "ID Subnet DCP"
}
variable "subnet-production-dca" {
  description = "ID Subnet DCA"
}
variable "vpc_security_group_ids" {
  description = "SG RDS Prod"
}
variable "name" {
  description = "Instance DB Name"
}
variable "db_name" {
  description = "Database"
}
variable "db_port" {
  description = "Port DB"
}
variable "db_username" {
  description = "Username"
}
variable "db_password" {
  description = "DB Password"
}
variable "db_engine" {
  description = "Engine DB"
}
variable "db_engine_version" {
  description = "DB engine version"
}
variable "db_parameter_group_name" {
  description = "DB Paramter Group"
}
