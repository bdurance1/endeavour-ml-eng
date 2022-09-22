variable "env_name" {
  description = "Environment name ex. dev, stage, prod etc."
  type        = string
}

variable "namespace" {
  description = "Application name."
  type        = string
}

variable "name" {
  description = "Component or solution name."
  type        = string
}

variable "deletion_window_in_days" {
  description = "The number of days until AWS KMS deletes the KMS key."
  type        = number
  default     = 30
}

variable "description" {
  description = "Description of the KMS key."
  type        = string
}

variable "policy" {
  description = "A valid policy JSON document."
  type        = string
  default     = ""
}
