# General Variables
variable "account" {
  description = "ID Root AWS Account"
}
variable "region" {
  description = "Region DCP to deploy"
}
variable "profile" {
  description = "Profile to account AWS"
  default     = "default"
}
variable "project" {
  description = "Name Project"
}
variable "domain" {
  description = "Domain Project"
}
variable "stage" {
  description = "Stage Project"
}
variable "group" {
  description = "Front or Back Microservices"
  default     = "backend"
}
variable "country" {
  description = "Country to deploy"
  default     = "co"
}

# Network
variable "cidr_block" {
  description = "CIDR Block to VPC"
}

# Database
variable "db_name" {
  description = "Name of Database"
}
variable "db_port" {
  description = "Port Mysql"
}

variable "db_username" {
  description = "Admin user to Dababase"
}
variable "db_password" {
  description = "Password to Database"
}
variable "cluster_name" {
  description = "Name of Mysql Cluster"
}
variable "db_engine" {
  default = "aurora-mysql"
}
variable "db_engine_version" {
  default = "5.7.mysql_aurora.2.10.2"
}
variable "db_parameter_group_name" {
  default = "default.aurora-mysql5.7"
}

# EC2

variable "ami_id" {
  description = "Ami to deploy"
}
variable "instance_type" {
  description = "Type of instance"
}
variable "volume_size" {
  description = "Volume Size EC2"
}

# Backend Microservices
variable "microservices_backend" {
  type = set(string)
  default = [
    "wordpress"
  ]
}
variable "container_port" {
  description = "Microservice Port"
}
variable "microservice_name" {
  description = "Microservice Name"
}
variable "domain_app" {
  description = "Domain to app"
}
variable "cpu" {
  description = "CPU"
}
variable "memory" {
  description = "Memory"
}
variable "ecr_name" {
  description = "ECR Name"
}