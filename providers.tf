# Provider y version de Terraform

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = {
      Environment = "${var.stage}"
      Project     = "${var.project}"
      Owner       = "${var.profile}"
      Region      = "${var.region}"
      Terraform   = true
    }
  }
}