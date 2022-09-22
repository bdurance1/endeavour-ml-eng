locals {
  kms_alias = var.env_name == null ? "${var.namespace}-${var.name}" : "${var.namespace}-${var.env_name}-${var.name}"
}
