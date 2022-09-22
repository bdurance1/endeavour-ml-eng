# TODO: change to output just module.vpc to remove repetition of output calls. 
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "database_subnets_ids" {
  value = module.vpc.database_subnets
}

output "database_subnets_cidr_blocks" {
  value = module.vpc.database_subnets_cidr_blocks
}

output "elasticache_subnets_ids" {
  value = module.vpc.elasticache_subnets
}

output "elasticache_subnets_cidr_blocks" {
  value = module.vpc.elasticache_subnets_cidr_blocks
}

output "apigateway_id" {
  value = aws_apigatewayv2_api.this.id
}

output "aws_apigatewayv2_stage_id" {
  value = aws_apigatewayv2_stage.this.id
}

output "apigateway_vpc_link_id" {
  value = aws_apigatewayv2_vpc_link.this.id
}
