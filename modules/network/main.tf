resource "aws_vpc" "iac" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name : "VPC ${var.project}"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_internet_gateway" "iac" {
  depends_on = [
    aws_vpc.iac
  ]
  vpc_id = aws_vpc.iac.id
  tags = {
    Name : "IG iac"
  }
}

resource "aws_vpc_dhcp_options" "iac" {
  domain_name = "iac.local"
  domain_name_servers = [
    "1.1.1.1",
    "8.8.8.8"
  ]
  ntp_servers = [
    "45.11.105.223",
    "194.0.5.123",
    "200.89.75.198",
    "45.11.105.243"
  ]

  tags = {
    Name = "DHCP Options iac"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.iac.id
  dhcp_options_id = aws_vpc_dhcp_options.iac.id
}

