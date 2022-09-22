module "api_gateway_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.namespace}-${var.env_name}-api-gateway-sg-${random_id.id.hex}"
  description = "API Gateway group for "
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]

  egress_rules = ["all-all"]

  tags = {
    Name        = "${var.namespace}-${var.env_name}-api-gateway-sg-${random_id.id.hex}"
    Environment = var.env_name
    Origin      = "terraform"
  }
}

resource "aws_apigatewayv2_vpc_link" "this" {
  name               = "${var.namespace}-${var.env_name}-api-vpc-link"
  security_group_ids = [module.api_gateway_security_group.security_group_id]
  subnet_ids         = module.vpc.public_subnets

  tags = {
    Name        = "${var.namespace}-${var.env_name}-api-vpc-link"
    Environment = var.env_name
    Origin      = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "api_gw_log_group" {
  name              = "/aws/api_gw/${var.namespace}/${var.env_name}/api_gw_log"
  retention_in_days = 30

  tags = {
    Name        = "/aws/ecs/${var.namespace}/${var.env_name}/api_gw_log"
    Environment = var.env_name
    Origin      = "terraform"
  }
}

resource "aws_apigatewayv2_api" "this" {
  name          = "${var.namespace}-${var.env_name}-api-gw"
  protocol_type = "HTTP"

  tags = {
    Name        = "${var.namespace}-${var.env_name}-api-gw"
    Environment = var.env_name
    Origin      = "terraform"
  }
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw_log_group.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }

  lifecycle {
    ignore_changes = [deployment_id]
  }

  tags = {
    Name        = "${var.namespace}-${var.env_name}-api-gw-stage"
    Environment = var.env_name
    Origin      = "terraform"
  }
}

# ==========================
# SERVICES DOMAIN NAME
# ==========================

resource "aws_apigatewayv2_domain_name" "this" {
  count = var.map_domain_name ? 1:0

  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn = module.acm.acm_certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "name" {
  count = var.map_domain_name ? 1:0

  api_id      = aws_apigatewayv2_api.this.id
  domain_name = aws_apigatewayv2_domain_name.this[count.index].id
  stage       = aws_apigatewayv2_stage.this.id
}

resource "aws_route53_record" "this_services-a" {
  count = var.map_domain_name ? 1:0

  name    = aws_apigatewayv2_domain_name.this[count.index].domain_name
  type    = "A"
  zone_id = aws_route53_zone.this.zone_id

  alias {
    name                   = aws_apigatewayv2_domain_name.this[count.index].domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.this[count.index].domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}

# resource "aws_route53_record" "this-ns" {
#   allow_overwrite = true
#   name            = aws_apigatewayv2_domain_name.this.domain_name
#   ttl             = 3600
#   type            = "NS"
#   zone_id         = aws_route53_zone.this.zone_id

#   records         = aws_route53_zone.this.name_servers 
# }
