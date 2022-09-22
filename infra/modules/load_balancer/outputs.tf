output "security_group_id" {
  value = aws_security_group.sec_grp_lb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.lb_trgt_grp.arn
}

output "listener" {
  value = aws_lb_listener.lb_lstnr
}

output "httpcode_target_3xx_count_cloudwatch_metric_alarm_id" {
  value = aws_cloudwatch_metric_alarm.httpcode_target_3xx_count.id
}

output "httpcode_target_3xx_count_cloudwatch_metric_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.httpcode_target_3xx_count.arn
}

output "httpcode_target_4xx_count_cloudwatch_metric_alarm_id" {
  value = aws_cloudwatch_metric_alarm.httpcode_target_4xx_count.id
}

output "httpcode_target_4xx_count_cloudwatch_metric_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.httpcode_target_4xx_count.arn
}

output "httpcode_target_5xx_count_cloudwatch_metric_alarm_id" {
  value = aws_cloudwatch_metric_alarm.httpcode_target_5xx_count.id
}

output "httpcode_target_5xx_count_cloudwatch_metric_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.httpcode_target_5xx_count.arn
}

output "httpcode_lb_5xx_count_cloudwatch_metric_alarm_id" {
  value = aws_cloudwatch_metric_alarm.httpcode_lb_5xx_count.id
}

output "httpcode_lb_5xx_count_cloudwatch_metric_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.httpcode_lb_5xx_count.arn
}

output "target_response_time_average_cloudwatch_metric_alarm_id" {
  value = aws_cloudwatch_metric_alarm.target_response_time_average.id
}

output "target_response_time_average_cloudwatch_metric_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.target_response_time_average.arn
}

output "target_minimum_unhealthy_hosts_cloudwatch_metric_alarm_id" {
  value = aws_cloudwatch_metric_alarm.target_unhealthy_hosts.id
}

output "target_minimum_unhealthy_hosts_cloudwatch_metric_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.target_unhealthy_hosts.arn
}

output "target_minimum_healthy_hosts_cloudwatch_metric_alarm_id" {
  value = aws_cloudwatch_metric_alarm.target_healthy_hosts.id
}

output "target_minimum_healthy_hosts_cloudwatch_metric_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.target_healthy_hosts.arn
}
