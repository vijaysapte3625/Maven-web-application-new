provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "subnet" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security_group" {
  source            = "./modules/security_group"
  vpc_id            = module.vpc.vpc_id
}

module "internet_gateway" {
  source            = "./modules/internet_gateway"
  vpc_id            = module.vpc.vpc_id
}

module "nat_gateway" {
  source            = "./modules/nat_gateway"
  public_subnet_id = module.subnet.public_subnet_id
}

module "ec2" {
  source             = "./modules/ec2"
  subnet_id          = module.subnet.private_subnet_id
  security_group_ids = [module.security_group.sg_id]
}

module "autoscaling" {
  source             = "./modules/autoscaling"
  subnet_ids         = [module.subnet.private_subnet_id]
  security_group_ids = [module.security_group.sg_id]
}

output "nexus_instance_ip" {
  value = module.ec2.public_ip
}
