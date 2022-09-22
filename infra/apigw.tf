# resource "aws_apigatewayv2_domain_name" "this" {
#   domain_name = local.domain_name

#   domain_name_configuration {
#     certificate_arn = aws_acm_certificate.this.arn
#     endpoint_type   = "REGIONAL"
#     security_policy = "TLS_1_2"
#   }
# }

# resource "aws_route53_zone" "this" {
#   name = local.domain_name
# }

# resource "aws_route53_record" "this-a" {
#   name    = aws_apigatewayv2_domain_name.this.domain_name
#   type    = "A"
#   zone_id = aws_route53_zone.this.zone_id

#   alias {
#     name                   = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].target_domain_name
#     zone_id                = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# resource "aws_route53_record" "this-ns" {
#   allow_overwrite = true
#   name            = aws_apigatewayv2_domain_name.this.domain_name
#   ttl             = 3600
#   type            = "NS"
#   zone_id         = aws_route53_zone.this.zone_id

#   records         = aws_route53_zone.this.name_servers 
# }
