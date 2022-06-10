locals {
  ecs_service_template_file = templatefile("otfp-fe.json.tpl", { 
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.deployment_region
    otlp_log_group_name = var.otlp_log_group_name
    deployment_env = var.deployment_env
  })
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.deployment_env}-otlp-fe-app"
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    =  local.ecs_service_template_file
}

resource "aws_ecs_service" "main" {
  name            = "${var.deployment_env}-otlp-fe"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.sg_ecs_id]
    subnets          = var.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.otlp_fe_app_target_group_id
    container_name   = "otfp-fe-app"
    container_port   = var.app_port
  }
}