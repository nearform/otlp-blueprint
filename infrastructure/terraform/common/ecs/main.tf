resource "aws_ecs_cluster" "main" {
  name = "${var.deployment_env}-${var.deployment_app_name}-cluster"
}

resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = "otlp-blueprint.local"
  description = "OTLP Blueprint Project private namespace"
  vpc         = var.vpc_id
}
