# For metric defintions https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#cluster_utilization  

locals {
  dimensions_map = {
      "ClusterName" = aws_ecs_cluster.ecs_cluster.name
      "ServiceName" = aws_ecs_service.ecs_service.name
  }

  # sns_topic_arn = aws_sns_topic.sns_topic.arn
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/aws/ecs/${var.namespace}/${var.environment}/${var.name}/ecslog"
  retention_in_days = 365

  tags = {
    Name        = "/aws/ecs/${var.namespace}/${var.environment}/${var.name}/ecslog"
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name                = "${var.namespace}-${var.environment}-${var.name}-cpu-utilization-high"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "median service cpu utilization high, over last 300s, for 1 period at threshold > 80%"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.dimensions_map

  tags = {
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name                = "${var.namespace}-${var.environment}-${var.name}-cpu-utilization-low"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 10
  alarm_description         = "median service cpu utilization low, over last 300s, for 1 period at threshold < 10%"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.dimensions_map

  tags = {
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name                = "${var.namespace}-${var.environment}-${var.name}-memory-utilization-high"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "median service memory utilization high, over last 300s, for 1 period at threshold > 80%"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.dimensions_map

  tags = {
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_low" {
  alarm_name                = "${var.namespace}-${var.environment}-${var.name}-memory-utilization-low"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 1
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 10
  alarm_description         = "median service memory utilization low, over last 300s, for 1 period at threshold < 10%"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.dimensions_map

  tags = {
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}
