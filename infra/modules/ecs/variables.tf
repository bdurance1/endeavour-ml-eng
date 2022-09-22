variable "environment" {
  description = "Environment name ex. dev, stage, prod etc."
  type        = string
}

variable "namespace" {
  description = "Application name."
  type        = string
}

variable "name" {
  description = "Component/service or solution name."
  type        = string
}

# Fargate Variables
variable "fargate_cpu" {
  description = "CPU size for fargate"
  type        = number
  default     = 1024
}
variable "fargate_mem" {
  description = "Memory to use for fargate"
  type        = number
  default     = 2048
}

# Builder Container Variables
variable "container_cpu" {
  description = "CPU to use for container, must be equal or less than fargate"
  type        = number
  default     = 1024
}

variable "container_mem" {
  description = "Memory to use for container, must be equal or less than fargate"
  type        = number
  default     = 2048
}

variable "container_port" {
  description = "value"
  type = number
}

# ECS Task Varaibles
variable "ecr_url" {
  description = "The container repository URL where the image is stored."
  type        = string
}

variable "image_tag" {
  description = "Image tag used when pulling from container repository."
  type        = string
  default     = "latest"
}

variable "environment_variables" {
  description = <<EOT
    List of maps of environment variables in key/pair json encoded to pass to container 
    ex. [{ name : 'ENV1', value : 'env_value1' }, { name : 'ENV2', value : 'env_value2' }] 
    Warning: clear text.
    EOT
  type        = list(map(string))
  default     = []
}

# ECS Service Variables
variable "task_instances" {
  description = "Number of instances of the task definition to spin-up and keep running."
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "The VPC id containing the subnets to put the fargate/container ex. module.vpc.vpc_id"
  type        = string
}

variable "subnets" {
  description = "List of subnets to put the fargate/container into."
  type        = list(string)
}

# ECS Service Load Balancer Variables
variable "load_balancer_target_group_arn" {
  description = "ex. aws_lb_target_group.*.arn"
  type        = string
}

variable "load_balancer_security_group_id" {
  description = "ex. aws_security_group.*.id"
  type        = list(any)
  default     = []
}

# ECS Autoscaling
variable "enable_autoscaling" {
  description = "Enable automatic scaling of task instances."
  type       = bool
  default     = true
}

variable "min_instances" {
  description = "Minimum number of task instances."
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of task instances."
  type        = number
  default     = 2
}

# TODO: should be called "cloudwatch_metric_alarm_action".
variable "cloudwatch_metric_alarm" {
  description = "A catch all for the following actions: alarm, ok, insufficient data ex. aws_sns_topic.sns_topic.arn"
}
