
resource "aws_alb" "main" {
  name            = "${var.deployment_env}-${var.deployment_app_name}-lb"
  subnets         = var.public_subnet_ids
  security_groups = [var.sg_alb_id]
}

resource "aws_alb_target_group" "app" {
  name        = "otlp-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.app_health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "fe_nginx_app_lblistner" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

resource "aws_alb_target_group" "jaeger" {
  name        = "jaeger-target-group"
  port        = 16686
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    port         = 14269
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.app_health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end_jaeger" {
  load_balancer_arn = aws_alb.main.id
  port              = 8081
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.jaeger.id
    type             = "forward"
  }
}