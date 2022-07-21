# Network 
module "network" {
  source     = "./modules/network"
  cidr_block = var.cidr_block
  project    = var.project
  domain     = var.domain
  region     = var.region
}

# RDS Database
module "database" {
  source                  = "./modules/database"
  project                 = var.project
  subnet-production-dcp   = local.subnet_databases_prod_a
  subnet-production-dca   = local.subnet_databases_prod_b
  vpc_security_group_ids  = [local.sg_rds_prod]
  name                    = var.cluster_name
  db_username             = var.db_username
  db_password             = var.db_password
  db_name                 = var.db_name
  db_port                 = var.db_port
  db_engine               = var.db_engine
  db_engine_version       = var.db_engine_version
  db_parameter_group_name = var.db_parameter_group_name
  depends_on = [
    module.network
  ]
}

# EC2 - Bastion
module "ec2" {
  source                 = "./modules/ec2"
  ami_id                 = var.ami_id
  project                = var.project
  instance_type          = var.instance_type
  subnet_id              = local.subnet_wordpress_a
  vpc_security_group_ids = [local.sg_ec2]
  volume_size            = var.volume_size
  domain_app             = var.domain_app
  region                 = var.region
}


#Backend - Microservicios 
module "backend" {
  source                      = "./modules/backend"
  project                     = var.project
  region                      = var.region
  account                     = var.account
  ecr_name                    = var.ecr_name
  certificate_arn             = local.certificate_arn
  security_groups             = local.sg_alb
  security_group_microservice = [local.sg_alb]
  db_host                     = module.database.db_endpoint
  db_username                 = var.db_username
  db_password                 = var.db_password
  db_name                     = var.db_name
  site_url                    = "fundacionbolivardavivienda.unoraya.com"
  subnets = [
    local.subnet_wordpress_a,
    local.subnet_wordpress_b
  ]
  vpc_id         = local.vpc_id
  container_port = var.container_port
  microservice   = var.microservice_name
  domain_app     = var.domain_app
  cpu            = var.cpu
  memory         = var.memory
  depends_on = [
    module.network, module.database
  ]
}

# Frontend
module "frontend" {
  source          = "./modules/frontend"
  project         = var.project
  region          = var.region
  bucket-name     = var.bucket-name
  certificate_arn = local.certificate_arn
  dns_alb         = module.backend.dns_alb
  account         = var.account
  depends_on = [
    module.network, module.backend
  ]
}