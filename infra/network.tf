module "network" {
  source = "./modules/network"

  env_name  = "dev"
  namespace = "endv"

  vpc_cidr_block = "10.0.0.0/16"
  region         = "ap-southeast-2"

  domain_name = "endvmleng.com"

}

resource "aws_sns_topic" "sns_topic" {
  name         = "endv-dev-sns-topic"
  display_name = "endv-dev-aws-cloudwatch-sns-alarms"

  tags = {
    Environment = "dev"
    Origin      = "terraform"
  }
}
