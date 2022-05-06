# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "alb_endpoint" {
  value       = module.alb_server.dns_alb
  description = "ALB endpoint"
}

output "ecr_repository_url" {
  value       = module.ecr_server.ecr_repository_url
  description = "URL of the ECR repository for the server image"
}

output "deployment_group_name" {
  value = module.codedeploy_server.deployment_group_name
}

output "application_name" {
  value = module.codedeploy_server.application_name
}

output "task_definition_family" {
  value = module.ecs_taks_definition_server.task_definition_family
}

output "ecs_role" {
  value = module.ecs_role.arn_role
}

output "ecs_task_role" {
  value = module.ecs_role.arn_role_ecs_task_role
}

output "aws_s3_bucket_site_id" {
  value = module.s3_assets.aws_s3_bucket_site_id
}

output "aws_s3_bucket_site_arn" {
  value = module.s3_assets.aws_s3_bucket_site_arn
}

output "aws_s3_bucket_website_domain" {
  value = module.s3_assets.aws_s3_bucket_website_domain
}

output "aws_s3_assets_bucket_id" {
  value = module.s3_assets.s3_bucket_id
}