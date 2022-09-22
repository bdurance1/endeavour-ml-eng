resource "aws_security_group" "sec_grp_lb" {
  name   = "${var.namespace}-${var.env_name}-${var.name}-sec-grp-lb"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.namespace}-${var.env_name}-${var.name}-sec-grp-lb"
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_security_group_rule" "sec_grp_lb_http_rule" {
  description       = "Only allow load balancer to reach the ECS service on the right port"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.sec_grp_lb.id
}

resource "aws_security_group_rule" "sec_grp_lb_ingres_https_rule" {
  description       = "Only allow load balancer to reach the ECS service on the right port"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.sec_grp_lb.id
}

resource "aws_security_group_rule" "sec_grp_lb_egress_rule" {
  description              = "Only allow load balancer to reach the ECS service on the right port"
  type                     = "egress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  source_security_group_id = var.sec_grp_ecs_id
  security_group_id        = aws_security_group.sec_grp_lb.id
}

resource "aws_lb" "lb" {
  name               = "${var.namespace}-${var.env_name}-${var.name}-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sec_grp_lb.id]
  subnets            = var.subnet_ids

  tags = {
    Name        = "${var.namespace}-${var.env_name}-${var.name}-lb"
    Environment = "${var.env_name}"
    Origin      = "terraform"
  }
}

resource "aws_lb_target_group" "lb_trgt_grp" {
  name        = "${var.namespace}-${var.env_name}-${var.name}"
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    protocol            = "HTTP"
    matcher             = "200-299"
    path                = local.health_check_route
    port                = var.port
  }

  depends_on = [
    aws_lb.lb
  ]
}

resource "aws_lb_listener" "lb_lstnr" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_trgt_grp.arn
    type             = "forward"
  }
}
