# General 761265910279
account = "761265910279"
project = "iac"
domain  = "unoraya.com"
stage   = "production"
region  = "us-east-1"

# Network
cidr_block = "10.2.0.0/16"

# Database
db_username  = "unoraya_database"
db_password  = "Comandos1992#***"
db_name      = "unoraya_fds"
db_port      = 3306
cluster_name = "cluster-aurora-postgrest"

# EC2 
ami_id        = "ami-0cff7528ff583bf9a"
instance_type = "t2.micro"
volume_size   = 8

# Backend Microservice
container_port    = "80"
microservice_name = "wordpress"
domain_app        = "fundacionbolivardavivienda.unoraya.com"
cpu               = 512
memory            = 1024
ecr_name          = "fundacionbolivar"

# Frontend 

bucket-name = "assets.fundacionbolivardavivienda.unoraya.com"
