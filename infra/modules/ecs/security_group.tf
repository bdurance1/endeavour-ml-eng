resource "aws_security_group" "ecs_security_group" {
  name = "${var.namespace}-${var.name}-ecs-security-group"

  vpc_id = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = var.load_balancer_security_group_id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.namespace}-${var.name}-ecs-security-group"
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}
