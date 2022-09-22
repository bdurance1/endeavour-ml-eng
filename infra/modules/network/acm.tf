# data "aws_route53_zone" "selected" {  
#   name         = var.domain_name
#   private_zone = false
# }

resource "aws_route53_zone" "this" {
  name = var.domain_name
}

module "acm" {

  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name = var.domain_name
  zone_id     = aws_route53_zone.this.zone_id

  wait_for_validation = true

  tags = {
    Name        = var.domain_name
    Environment = var.env_name
    Origin      = "terraform"
  }
}
