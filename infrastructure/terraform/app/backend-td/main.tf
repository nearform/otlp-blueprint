locals {
  ecs_service_template_file = templatefile("otfp-be.json.tpl", {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.deployment_region
    otlp_log_group_name = var.otlp_log_group_name
    deployment_env = var.deployment_env
    db_host        = var.db_host
    db_port        = var.db_port
    db_name        = var.db_name
    db_username    = var.db_username
    database_secret_arn = var.secrets_arn
  })
}

resource "aws_iam_role_policy" "password_db_policy" {
  name = "${var.deployment_env}-otlp-be-db-access"
  role = var.ecs_task_execution_role_id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "secretsmanager:GetSecretValue"
        ],
        "Effect": "Allow",
        "Resource": [
          "${var.secrets_arn}"
        ]
      },
      {
        "Action": [
          "ssm:GetParameters"
        ],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:ssm:us-east-1:101259067028:parameter/*"
        ]
      }
    ]
  }
  EOF
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.deployment_env}-otlp-be-app"
  task_role_arn            = var.ecs_task_execution_role_arn
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = local.ecs_service_template_file
}

resource "aws_ecs_service" "main" {
  name            = "${var.deployment_env}-otlp-be"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  service_registries {
    registry_arn = aws_service_discovery_service.main.arn
  }

  network_configuration {
    security_groups  = [var.sg_ecs_id]
    subnets          = var.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.otlp_be_app_target_group_id
    container_name   = "otfp-be-app"
    container_port   = var.app_port
  }
}

resource "aws_service_discovery_service" "main" {
  name = "otlp-be"
  dns_config {
    namespace_id = var.ecs_service_discovery_namespace_id
    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
