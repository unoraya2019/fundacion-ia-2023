locals {
  vpc_id                  = module.network.vpc_id
  sg_rds_prod             = module.network.sg_rds_prod
  sg_alb                  = module.network.sg_alb
  sg_ec2                  = module.network.sg_ec2
  certificate_arn         = module.network.certificate_arn
  subnet_wordpress_a      = module.network.subnet_wordpress_a
  subnet_wordpress_b      = module.network.subnet_wordpress_b
  subnet_databases_prod_a = module.network.subnet_databases_prod_a
  subnet_databases_prod_b = module.network.subnet_databases_prod_b
  zone_local_id           = module.network.zone_id
}