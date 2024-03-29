resource "aws_security_group" "sg_lb" {
  name        = "${var.deployment_env}-${var.deployment_app_name}-lb-sg"
  description = "controls access to the Application Load Balancer (ALB)"
  vpc_id      = var.vpc_id

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
  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 8082
    to_port     = 8082
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 8083
    to_port     = 8083
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
  vpc_id      = var.vpc_id


  tags = var.tags

  ingress {
    protocol        = "tcp"
    from_port       = 14250
    to_port         = 14250
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 14250
    to_port   = 14250
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 16685
    to_port         = 16685
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 16685
    to_port   = 16685
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 16686
    to_port         = 16686
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 16686
    to_port   = 16686
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 4317
    to_port         = 4317
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 4317
    to_port   = 4317
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 4318
    to_port         = 4318
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 4318
    to_port   = 4318
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 13133
    to_port         = 13133
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 13133
    to_port   = 13133
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 8080
    to_port         = 8080
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 8080
    to_port   = 8080
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 3000
    to_port         = 3000
    security_groups = [aws_security_group.sg_lb.id]
    self            = false
  }
  ingress {
    protocol  = "tcp"
    from_port = 3000
    to_port   = 3000
    self      = true
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.deployment_env}-${var.deployment_app_name}-postgres-sg"
  description = "controls access to the rds postgres database"
  vpc_id      = var.vpc_id

  tags = var.tags

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
