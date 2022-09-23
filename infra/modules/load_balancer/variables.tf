variable "env_name" {
  description = "Environment name ex. dev, stage, prod etc."
  type = string
}

variable "namespace" {
  description = "Application name"
  type = string
}

variable "name" {
  description = "Component or solution name."
  type = string
}

variable "port" {
    description = "Load balancer egress rule port i.e. the container port."
    type = number
}

variable "vpc_id" {
  description = "VPC ID ex. module.network.vpc_id"
  type = string
}

variable "cidr_blocks" {
  description = "VPC CIDR block ex. module.network.cidr_block"
  type = list(string)
}

variable "subnet_ids" {
  description = "Subnet IDs ex. module.network.subnet_ids"
  type = list(string)
}

variable "sec_grp_ecs_id" {
  description = "Security group id for ECS resource ex. module.container_service.sec_grp_ecs_id"
  type = string
}

variable "health_check_route" {
  description = "Health check route."
  type = string
  default = null
}

variable "health_check_interval" {
  description = "Approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds"
  type = number
  default = 60
}

variable "health_check_timeout" {
  description = "Amount of time, in seconds, during which no response means a failed health check. Range is 2 to 120 seconds."
  type = number
  default = 30
}

# TODO: should be called "cloudwatch_metric_alarm_action".
variable "cloudwatch_metric_alarm" {
  description = "A catch all for the following actions: alarm, ok, insufficient data ex. aws_sns_topic_arn"
}
