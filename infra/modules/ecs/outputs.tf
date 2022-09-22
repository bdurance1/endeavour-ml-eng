output "ecs_sec_grp_id" {
  value = aws_security_group.ecs_security_group.id
}

output "cpu_high_alarm_id" {
  value = aws_cloudwatch_metric_alarm.cpu_high.id
}

output "cpu_high_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "cpu_low_alarm_id" {
  value = aws_cloudwatch_metric_alarm.cpu_low.id
}

output "cpu_low_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.cpu_low.arn
}

output "memory_high_alarm_id" {
  value = aws_cloudwatch_metric_alarm.memory_high.id
}

output "memory_high_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.memory_high.arn
}

output "memory_low_alarm_id" {
  value = aws_cloudwatch_metric_alarm.memory_low.id
}

output "memory_low_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.memory_low.arn
}
