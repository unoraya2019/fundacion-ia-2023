# Backup estados terraform para este proyecto

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "iac-wp-iac-test"
    key     = "iac/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}
