module "load_balancer" {
  source = "./modules/load_balancer"

  env_name  = "dev"
  namespace = "endv"
  name      = "service"

  port                  = 8000
  vpc_id                = module.network.vpc_id
  subnet_ids            = module.network.private_subnets_ids
  sec_grp_ecs_id        = module.ecs.ecs_sec_grp_id
  cidr_blocks           = [module.network.vpc_cidr_block]
  health_check_interval = 120
  health_check_route    = "/health"

  cloudwatch_metric_alarm = aws_sns_topic.sns_topic.arn
}
