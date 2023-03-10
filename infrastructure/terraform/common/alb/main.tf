
resource "aws_alb" "main" {
  name            = "${var.deployment_env}-${var.deployment_app_name}-lb"
  subnets         = var.public_subnet_ids
  security_groups = [var.sg_alb_id]
}

# Sample Nginx app for testing

resource "aws_alb_target_group" "sample_nginx_app" {
  name        = "sample-nginx-target-group"
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
    target_group_arn = aws_alb_target_group.sample_nginx_app.id
    type             = "forward"
  }
}

# Jaeger frontend 
resource "aws_alb_target_group" "jaeger_all_in_one_app" {
  name        = "jaeger-target-group"
  port        = 16686
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    port                = 16686
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
resource "aws_alb_listener" "jaeger_lblistner" {
  load_balancer_arn = aws_alb.main.id
  port              = 8082
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.jaeger_all_in_one_app.id
    type             = "forward"
  }
}

# OTLP sample app frontend runs in nginx

resource "aws_alb_target_group" "otlp_frontend_app" {
  name        = "otlp-fe-target-group"
  port        = 8080
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
resource "aws_alb_listener" "fe_otlp_lblistner" {
  load_balancer_arn = aws_alb.main.id
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.otlp_frontend_app.id
    type             = "forward"
  }
}

# Backend 

resource "aws_alb_target_group" "otlp_backend_app" {
  name        = "otlp-backend-target-group"
  port        = 3000
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
resource "aws_alb_listener" "otlp_backend_lblistner" {
  load_balancer_arn = aws_alb.main.id
  port              = 8081
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.otlp_backend_app.id
    type             = "forward"
  }
}

# OTLP Collector 

resource "aws_alb_target_group" "otlp_collector" {
  name        = "otlp-collector-target-group"
  port        = 4318
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    port                = 13133
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "otlp_collector_app_lblistner" {
  load_balancer_arn = aws_alb.main.id
  port              = 8083
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.otlp_collector.id
    type             = "forward"
  }
}

# Route53 Record for ALB
data "aws_route53_zone" "otlp_abl_dns" {
  name = "${var.alb_dns_zone}."
}

resource "aws_route53_record" "otlp_alb_dns" {
  name    = "otlp-collector.${data.aws_route53_zone.otlp_abl_dns.name}"
  type    = "A"
  zone_id = data.aws_route53_zone.otlp_abl_dns.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_alb.main.dns_name
    zone_id                = aws_alb.main.zone_id
  }
}

