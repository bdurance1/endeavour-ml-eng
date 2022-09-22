resource "random_id" "id" {
  byte_length = 4
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name = "${var.namespace}-${var.env_name}-${random_id.id.hex}"
  cidr = var.vpc_cidr_block

  azs = ["${var.region}a", "${var.region}b", "${var.region}c"]

  # TODO: programmatically assign using cidrsubnet()
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

  # Cloudwatch log group and IAM role will be created
  enable_flow_log                                 = true
  create_flow_log_cloudwatch_log_group            = true
  create_flow_log_cloudwatch_iam_role             = true
  flow_log_max_aggregation_interval               = 60
  flow_log_cloudwatch_log_group_retention_in_days = 365
  

  # By not using the tag 'Name'. The resource names created by this module will be suffixed
  # appropriately. 
  tags = {
    Environment = var.env_name
    Origin      = "terraform"
  }
}
