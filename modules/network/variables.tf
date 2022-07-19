variable "cidr_block" {
  description = "CIDR Global para la infraestructura"
}
variable "project" {
  description = "Name Project"
}
variable "domain" {
  description = "Domain Project"
}
variable "region" {
  description = "Region to deploy"
}
# Rules to Security Group

variable "egress_rules_sg_rds_prod" {
  description = "egress_rules_sg_rds_prod"
  default = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      from_port = 0
      to_port   = 0
      protocol  = "-1"
    }
  ]
}

variable "ingress_rules_sg_rds_prod" {
  description = "ingress_rules_sg_rds_prod"
  default = [
    {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      from_port = 3306
      to_port   = 3306
      protocol  = "tcp"
    }
  ]
}

# ALB

variable "egress_rules_sg_alb" {
  description = "egress_rules_sg_alb"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }

  ]
}
variable "ingress_rules_sg_alb" {
  description = "ingress_rules_sg_alb"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    }
  ]
}

# ec2

variable "egress_rules_sg_ec2" {
  description = "egress_rules_sg_ec2"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }

  ]
}
variable "ingress_rules_sg_ec2" {
  description = "ingress_rules_sg_ec2"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    }
  ]
}