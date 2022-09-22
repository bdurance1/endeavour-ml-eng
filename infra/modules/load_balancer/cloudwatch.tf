# For metric defintions https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html

locals {
  target_group_dimensions_map = {
    "TargetGroup"  = aws_lb_target_group.lb_trgt_grp.arn_suffix
    "LoadBalancer" = aws_lb.lb.arn_suffix
  }

  load_balancer_dimensions_map = {
    "LoadBalancer" = aws_lb.lb.arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_3xx_count" {
  alarm_name                = "${var.namespace}-${var.env_name}-${var.name}-httpcode-target-3xx-count-high-alert"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1 # periods to evaluate for the alarm
  metric_name               = "HTTPCode_Target_3XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = 300 # over x seconds
  statistic                 = "Sum"
  threshold                 = 20 # x codes over a period
  treat_missing_data        = "missing"
  alarm_description         = "http code 3xx count for target, greater than 20, over last 300s, for 1 period"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.target_group_dimensions_map

  tags = {
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_4xx_count" {
  alarm_name                = "${var.namespace}-${var.env_name}-${var.name}-httpcode-target-4xx-count-high-alert"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "HTTPCode_Target_4XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = 20
  treat_missing_data        = "missing"
  alarm_description         = "http code 4xx count for target, greater than 20, over last 300s, for 1 period"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.target_group_dimensions_map

  tags = {
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_count" {
  alarm_name                = "${var.namespace}-${var.env_name}-${var.name}-httpcode-target-5xx-count-high-alert"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "HTTPCode_Target_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = 20
  treat_missing_data        = "missing"
  alarm_description         = "http code 5xx count for target, greater than 20, over last 300s, for 1 period"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.target_group_dimensions_map

  tags = {
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_lb_5xx_count" {
  alarm_name                = "${var.namespace}-${var.env_name}-${var.name}-httpcode-lb-5xx-count-high-alert"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "HTTPCode_ELB_5XX_CountFtarget"
  namespace                 = "AWS/ApplicationELB"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = 20
  treat_missing_data        = "missing"
  alarm_description         = "http code 5xx count for load balancer, greater than 20, over last 300s, for 1 period"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.load_balancer_dimensions_map

  tags = {
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "target_response_time_average" {
  alarm_name                = "${var.namespace}-${var.env_name}-${var.name}-target-response-time-high-alert"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "TargetResponseTime"
  namespace                 = "AWS/ApplicationELB"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 0.5 # maximum average seconds over a period
  treat_missing_data        = "missing"
  alarm_description         = "mean target response time for load balancer, greater than 0.5s, over 300s, for 1 period"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.target_group_dimensions_map

  tags = {
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "target_unhealthy_hosts" {
  alarm_name                = "${var.namespace}-${var.env_name}-${var.name}-target-minimum-unhealthy-hosts"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = 300
  statistic                 = "Minimum"
  threshold                 = 1
  alarm_description         = "Unhealthy host count is greater than 1, over last 300s, for 1 period"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.target_group_dimensions_map

  tags = {
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "target_healthy_hosts" {
  alarm_name                = "${var.namespace}-${var.env_name}-${var.name}-target-minimum-healthy-hosts"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = 300
  statistic                 = "Minimum"
  threshold                 = 1
  alarm_description         = "Healthy host count is less than or equal to 1, over last 300s, for 1 period"
  alarm_actions             = [var.cloudwatch_metric_alarm]
  ok_actions                = [var.cloudwatch_metric_alarm]
  insufficient_data_actions = [var.cloudwatch_metric_alarm]
  dimensions                = local.target_group_dimensions_map

  tags = {
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}
