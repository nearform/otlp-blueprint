resource "aws_ecs_cluster" "main" {
  name = "${var.deployment_env}-${var.deployment_app_name}-cluster"
}