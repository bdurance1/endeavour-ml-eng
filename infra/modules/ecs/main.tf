
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.namespace}-${var.environment}-${var.name}"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  # Fargate cpu/memory options: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
  cpu    = var.fargate_cpu
  memory = var.fargate_mem

  container_definitions = jsonencode(
    [
      {
        name         = "${var.namespace}-${var.name}-container"
        image        = "${var.ecr_url}:${var.image_tag}"
        cpu          = "${var.container_cpu}"
        memory       = "${var.container_mem}"
        essential    = true
        portMappings = [{ containerPort = var.container_port }]
        environment  = var.environment_variables == [] ? null : var.environment_variables

        logConfiguration = {
          logDriver     = "awslogs"
          secretOptions = null
          options = {
            "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
            "awslogs-region"        = data.aws_region.current_region.name
            "awslogs-stream-prefix" = "${var.namespace}-${var.name}"
          }
        }
      }
    ]
  )

  tags = {
    Name        = "${var.namespace}-${var.environment}-${var.name}-ecs-service"
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name               = "${var.namespace}-${var.environment}-${var.name}-ecs-cluster"
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
  }

  tags = {
    Name        = "${var.namespace}-${var.environment}-${var.name}-ecs-cluster"
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name             = "${var.namespace}-${var.environment}-${var.name}-ecs-service"
  cluster          = aws_ecs_cluster.ecs_cluster.id
  task_definition  = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count    = var.task_instances
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = "${var.namespace}-${var.name}-container"
    container_port   = var.container_port 
  }

}

resource "aws_appautoscaling_target" "ecs_autoscaling_target" {
  count              = var.enable_autoscaling ? 1 : 0
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}" # service/(cluster_name)/(service_name)
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_instances
  max_capacity       = var.max_instances

}
