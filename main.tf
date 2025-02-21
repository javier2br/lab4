##########################################
# Backend y Proveedor
##########################################
terraform {
  backend "s3" {
    bucket         = "lockid-backend"
    key            = "terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform_state"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-3"
  profile = "default"
}
########################################## FIN BACKEND Y PROVEEDOR ##########################################
##########################################

module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = "10.0.0.0/16"
  vpc_name        = "lab4-vpc"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  public_azs      = ["eu-west-3a", "eu-west-3b"]
  private_azs     = ["eu-west-3a", "eu-west-3b"]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

module "secrets" {
  source      = "./modules/secrets"
  secret_name = "rds-credentials"
  environment = "LAB4"
  db_username = "postgresadmin"
  db_password = "SuperSecurePassword123!"
}
module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id # Suponiendo que tienes un módulo de VPC con output vpc_id
  alb_sg_name      = "lab4-alb-sg"
  rds_sg_name      = "lab4-rds-sg"
  web_sg_name      = "lab4-web-sg"
  alb_ingress_cidr = ["0.0.0.0/0"]
  rds_ingress_cidr = ["10.0.0.0/16"]
  ####  ssh_allowed_cidrs = ["tu.ip.publica/32"]
}

output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

output "rds_sg_id" {
  value = module.security_groups.rds_sg_id
}

output "web_sg_id" {
  value = module.security_groups.web_sg_id
}



module "rds" {
  source               = "./modules/rds"
  db_subnet_group_name = "rds-subnet-group"
  private_subnet_ids   = module.vpc.private_subnet_ids
  db_identifier        = "rds-postgres-instance"
  db_name              = "cms_db"
  db_username          = "postgresadmin"
  db_password          = "SuperSecurePassword123!"
  rds_sg_ids           = [module.security_groups.rds_sg_id] # Reemplaza con el SG para RDS si no funcionara  ####["sg-xxxxxxxx"]  
}

module "asg_alb" {
  source        = "./modules/asg_alb"
  ami_id        = "ami-00c589b38b4ec4597" # Reemplaza con una AMI de Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "m"

  ec2_sg_ids         = [module.security_groups.web_sg_id] # SG para instancias EC2 (defínelo o créalo)
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
  alb_sg_ids         = [module.security_groups.alb_sg_id] # SG para ALB (puede ser el creado en el módulo vpc o definirlo aquí)


  # certificate_arn    = "arn:aws:acm:eu-west-3:640168456957:certificate/a1469ea9-1f91-401f-989c-2800ce1d2c30"   #  module.vpc.vpc_id != "" ? module.asg_alb.certificate_arn : ""  # Debes obtener el certificado emitido (o usar una variable)
}

module "route53_internal" {
  source          = "./modules/route53_internal"
  internal_domain = "lab4.internal"
  vpc_id          = module.vpc.vpc_id
}

module "s3_cloudfront" {
  source      = "./modules/s3_cloudfront"
  bucket_name = "lab4-cms-images"
}

module "cache" {
  source                = "./modules/cache"
  cache_cluster_id      = "lab4-cache"
  private_subnet_ids    = module.vpc.private_subnet_ids
  cache_subnet_group_name = "lab4-cache-subnet-group"
  cache_engine          = "redis"
  cache_node_type       = "cache.t2.micro"
  num_cache_nodes       = 1
  parameter_group_name  = "default.redis7"
  cache_port            = 6379
  cache_sg_ids          = [ module.security_groups.cache_sg_id ]
}

output "alb_dns" {
  value = module.asg_alb.alb_dns_name
}

output "cloudfront_domain" {
  value = module.s3_cloudfront.cloudfront_domain_name
}
