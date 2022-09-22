resource "aws_kms_key" "key" {
  description              = var.description
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = var.policy
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = true
  enable_key_rotation      = true
  multi_region             = false

  tags = {
    Name        = "${local.kms_alias}"
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/${local.kms_alias}"
  target_key_id = aws_kms_key.key.id
}
