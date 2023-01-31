locals {
  ecs_service_template_file = templatefile("container-def.json.tpl", {
    app_image           = var.app_image
    app_port            = var.app_port
    frontend_app_port   = var.frontend_app_port
    grpc_app_port       = var.grpc_app_port
    http_otlp_app_port  = var.http_otlp_app_port
    jaeger_app_port     = var.jaeger_app_port
    fargate_cpu         = var.fargate_cpu
    fargate_memory      = var.fargate_memory
    aws_region          = var.deployment_region
    otlp_log_group_name = var.otlp_log_group_name
  })
}

resource "aws_ecs_task_definition" "jaeger_app" {
  family                   = "jaeger-app-task"
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = local.ecs_service_template_file
}

resource "aws_ecs_service" "main" {
  name            = "jaeger-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.jaeger_app.arn
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
    target_group_arn = var.jaeger_app_target_group_id
    container_name   = "jaeger-app" #TODO: this should come from the container def template.
    container_port   = var.frontend_app_port
  }
}

resource "aws_service_discovery_service" "main" {
  name = "jaeger-service"
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
