output "key_alias" {
  description = "The key's alias."
  value       = aws_kms_alias.key_alias.name
}

output "key_arn" {
  description = "The key's arn."
  value       = aws_kms_key.key.arn
}

output "key_id" {
  description = "The key's globally unique identifier."
  value       = aws_kms_key.key.id
}
