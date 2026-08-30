module "vpc" {
  source = "./modules/vpc"

  vpc_cidr               = var.vpc_cidr
  public_sn_cidr          = var.public_sn_cidr
  private_sn_cidr          = var.private_sn_cidr
  route_table_cidr_block = var.route_table_cidr_block
}
