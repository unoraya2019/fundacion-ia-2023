variable "project" {
  description = "Name Project"
}
variable "region" {
  description = "Region to deploy"
}
variable "ami_id" {
  description = "Ami to deploy"
}
variable "instance_type" {
  description = "Type of instance"
}
variable "associate_public_ip_address" {
  default = true
}
variable "subnet_id" {
  description = "Private Subnet"
}
variable "vpc_security_group_ids" {
  description = "SG to EC2"
}
variable "domain_app" {
  description = "Domain APP"
}
variable "volume_size" {
  description = "Size EBS Disk"
}