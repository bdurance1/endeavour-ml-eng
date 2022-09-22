# resource "aws_acm_certificate" "this" {
#   domain_name       = local.domain_name
#   validation_method = "DNS"

#   tags = {
#     Name = "${local.namespace}-acm-endvservices"
#   }
# }

# resource "aws_acm_certificate_validation" "this" {
#   certificate_arn = aws_acm_certificate.this.arn
# }
