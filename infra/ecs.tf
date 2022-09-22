module "ecs" {
  source = "./modules/ecs"

  environment = "dev"
  namespace   = "endv"
  name        = "service"

  ecr_url   = "651002364466.dkr.ecr.ap-southeast-2.amazonaws.com/endv-ml-eng"  # FIXME: module.ecr.container_repository_url
  image_tag = "latest"

  container_port = 5000
  container_cpu  = 2048
  container_mem  = 16384

  fargate_cpu = 2048
  fargate_mem = 16384

  environment_variables = []

  task_instances = 2
  vpc_id         = module.network.vpc_id
  subnets        = module.network.private_subnets_ids

  load_balancer_target_group_arn  = module.load_balancer.target_group_arn
  load_balancer_security_group_id = [module.load_balancer.security_group_id]

  enable_autoscaling = true
  min_instances      = 2
  max_instances      = 4

  cloudwatch_metric_alarm = aws_sns_topic.sns_topic.arn
}
