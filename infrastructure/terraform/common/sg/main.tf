resource "aws_security_group" "sg_lb" {
  name        = "${var.deployment_env}-${var.deployment_app_name}-lb-sg"
  description = "controls access to the Application Load Balancer (ALB)"

  tags = var.tags 

  ingress {
    protocol    = "tcp"
    from_port   = 8081
    to_port     = 8081
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_ecs_tasks" {
  name        = "${var.deployment_env}-${var.deployment_app_name}-ecs-tasks-sg"
  description = "allow inbound access from the ALB only"

  tags = var.tags 

  ingress {
    protocol        = "tcp"
    from_port       = 16686
    to_port         = 16686
    security_groups = [aws_security_group.sg_lb.id]
    self        = false
  }
  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.sg_lb.id]
    self        = false
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
