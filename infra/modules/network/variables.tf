variable "env_name" {
  description = "Environment name ex. dev, stage, prod etc."
  type        = string
}

variable "namespace" {
  description = "Application name."
  type        = string
  default     = "endv"
}

variable "vpc_cidr_block" {
  description = "Specify a range of IPv4 addresses for the VPC"
  type        = string
  default     = "10.0.0.0/20"
}

variable "region" {
  description = "AWS Region. "
  type        = string
  default     = "ap-southeast-2"
}

variable "domain_name" {
  description = "Domain name for the services"
  type        = string
}

variable "map_domain_name" {
  description = "Prevent the domain name mapping from occurring"
  type        = bool
  default     = true
}
