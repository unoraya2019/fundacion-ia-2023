variable "project" {
  description = "Name Project"
}
variable "stage" {
  description = "Stage"
  default     = "production"
}
variable "group" {
  description = "Type microservice"
  default     = "backend"
}
variable "type" {
  description = "Resource Type"
  default     = "cluster"
}
variable "monitoring" {
  default = "enabled"
}
variable "account" {
  description = "ID Root Account AWS"
}
variable "region" {
  description = "Region to Deploy"
}
variable "certificate_arn" {
  description = "ARN Certificate Wildcard SSL"
}
variable "security_groups" {
  description = "ID Security Group"
}
variable "security_group_microservice" {
  description = "ID Security Group Microservice"
}
variable "subnets" {
  description = "Subnets to deploy"
}
variable "enable_deletion_protection" {
  default = false
}
variable "container_port" {
  description = "Port to microservices"
}
variable "microservice" {
  description = "Name of microservice"
}
variable "vpc_id" {
  description = "ID VPC"
}
variable "cpu" {
  description = "Number of cpu units used by the task."
  default     = 256
}
variable "memory" {
  description = "Amount (in MiB) of memory used by the task."
  default     = 512
}
variable "deregistration_delay" {
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused."
  default     = 300
}
variable "domain_app" {
  description = "Name Host Header"
}
variable "target_value" {
  description = "Percent to scaling"
  default     = 70
}

# Databases

variable "db_host" {
  description = "Database"
}
variable "db_name" {
  description = "Database"
}
variable "db_username" {
  description = "Username"
}
variable "db_password" {
  description = "DB Password"
}
variable "site_url" {
  description = "URL Site"
}

# ECR

variable "ecr_name" {
  description = "Name ECR"
}