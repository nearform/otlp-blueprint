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
    from_port       = 16686
    to_port         = 16686
    security_groups = [aws_security_group.sg_lb.id]
    self        = false
  }
  ingress {
    protocol        = "tcp"
    from_port       = 55681
    to_port         = 55681
    security_groups = [aws_security_group.sg_lb.id]
    self        = false
  }
  ingress {
    protocol        = "tcp"
    from_port       = 13133
    to_port         = 13133
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

data "aws_subnet" "private_subnets" {
  count    = var.private_subnet_ids
  id       = element(var.private_subnet_ids, count.index)
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
    cidr_blocks = [for s in data.aws_subnet.private_subnets : s.cidr_block]
  }
  
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}