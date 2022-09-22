resource "aws_apigatewayv2_integration" "this" {
  api_id             = module.network.apigateway_id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = module.load_balancer.listener.arn

  connection_type = "VPC_LINK"
  connection_id   = module.network.apigateway_vpc_link_id

  depends_on = [
    module.load_balancer.listner
  ]
}

resource "aws_apigatewayv2_route" "get" {
  api_id    = module.network.apigateway_id
  route_key = "GET /health"
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}

resource "aws_apigatewayv2_route" "post" {
  api_id    = module.network.apigateway_id
  route_key = "POST /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}
