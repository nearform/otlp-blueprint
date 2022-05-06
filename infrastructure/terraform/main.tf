# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================
          Root file
============================*/

# ------- Providers -------
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Created_by = "Terraform"
      Project    = "AWS_demo_fullstack_devops"
    }
  }
}

# ------- Random numbers intended to be used as unique identifiers for resources -------
resource "random_id" "RANDOM_ID" {
  byte_length = "2"
}

# ------- Account ID -------
data "aws_caller_identity" "id_current_account" {}

# ------- Networking -------
module "networking" {
  source = "./Modules/Networking"
  cidr   = ["10.120.0.0/16"]
  name   = var.environment_name
}

# ------- Creating Target Group for the server ALB blue environment -------
module "target_group_server_blue" {
  source              = "./Modules/ALB"
  create_target_group = true
  name                = "tg-${var.environment_name}-s-b"
  port                = 80
  protocol            = "HTTP"
  vpc                 = module.networking.aws_vpc
  tg_type             = "ip"
  health_check_path   = "/status"
  health_check_port   = var.port_app_server
}

# ------- Creating Target Group for the server ALB green environment -------
module "target_group_server_green" {
  source              = "./Modules/ALB"
  create_target_group = true
  name                = "tg-${var.environment_name}-s-g"
  port                = 80
  protocol            = "HTTP"
  vpc                 = module.networking.aws_vpc
  tg_type             = "ip"
  health_check_path   = "/status"
  health_check_port   = var.port_app_server
}

# ------- Creating Security Group for the server ALB -------
module "security_group_alb_server" {
  source              = "./Modules/SecurityGroup"
  name                = "alb-${var.environment_name}-server"
  description         = "Controls access to the server ALB"
  vpc_id              = module.networking.aws_vpc
  cidr_blocks_ingress = ["0.0.0.0/0"]
  ingress_port        = 80
}

# ------- Creating Server Application ALB -------
module "alb_server" {
  source         = "./Modules/ALB"
  create_alb     = true
  name           = "${var.environment_name}-ser"
  subnets        = [module.networking.public_subnets[0], module.networking.public_subnets[1]]
  security_group = module.security_group_alb_server.sg_id
  target_group   = module.target_group_server_blue.arn_tg
}

# ------- ECS Role -------
module "ecs_role" {
  source             = "./Modules/IAM"
  create_ecs_role    = true
  name               = var.iam_role_name["ecs"]
  name_ecs_task_role = var.iam_role_name["ecs_task_role"]
}

# ------- Creating a IAM Policy for role -------
module "ecs_role_policy" {
  source        = "./Modules/IAM"
  name          = "ecs-ecr-${var.environment_name}"
  create_policy = true
  attach_to     = module.ecs_role.name_role
}

# ------- Creating server ECR Repository to store Docker Images -------
module "ecr_server" {
  source = "./Modules/ECR"
  name   = "repo-server"
}

# ------- Creating ECS Task Definition for the server -------
module "ecs_taks_definition_server" {
  source             = "./Modules/ECS/TaskDefinition"
  name               = "${var.environment_name}-server"
  container_name     = var.container_name["server"]
  execution_role_arn = module.ecs_role.arn_role
  task_role_arn      = module.ecs_role.arn_role_ecs_task_role
  cpu                = 256
  memory             = "512"
  docker_repo        = module.ecr_server.ecr_repository_url
  region             = var.aws_region
  container_port     = var.port_app_server
}

# ------- Creating a server Security Group for ECS TASKS -------
module "security_group_ecs_task_server" {
  source          = "./Modules/SecurityGroup"
  name            = "ecs-task-${var.environment_name}-server"
  description     = "Controls access to the server ECS task"
  vpc_id          = module.networking.aws_vpc
  ingress_port    = var.port_app_server
  security_groups = [module.security_group_alb_server.sg_id]
}


# ------- Creating ECS Cluster -------
module "ecs_cluster" {
  source = "./Modules/ECS/Cluster"
  name   = var.environment_name
}

# ------- Creating ECS Service server -------
module "ecs_service_server" {
  depends_on          = [module.alb_server]
  source              = "./Modules/ECS/Service"
  name                = "${var.environment_name}-server"
  desired_tasks       = 1
  arn_security_group  = module.security_group_ecs_task_server.sg_id
  ecs_cluster_id      = module.ecs_cluster.ecs_cluster_id
  arn_target_group    = module.target_group_server_blue.arn_tg
  arn_task_definition = module.ecs_taks_definition_server.arn_task_definition
  subnets_id          = [module.networking.private_subnets_server[0], module.networking.private_subnets_server[1]]
  container_port      = var.port_app_server
  container_name      = var.container_name["server"]
}


# ------- Creating ECS Autoscaling policies for the server application -------
module "ecs_autoscaling_server" {
  depends_on   = [module.ecs_service_server]
  source       = "./Modules/ECS/Autoscaling"
  name         = "${var.environment_name}-server"
  cluster_name = module.ecs_cluster.ecs_cluster_name
  min_capacity = 1
  max_capacity = 4
}


# ------- Creating IAM roles used during the pipeline excecution -------
module "devops_role" {
  source             = "./Modules/IAM"
  create_devops_role = true
  name               = var.iam_role_name["devops"]
}

module "codedeploy_role" {
  source                 = "./Modules/IAM"
  create_codedeploy_role = true
  name                   = var.iam_role_name["codedeploy"]
}

# ------- Creating an IAM Policy for role ------- 
module "policy_devops_role" {
  source                = "./Modules/IAM"
  name                  = "devops-${var.environment_name}"
  create_policy         = true
  attach_to             = module.devops_role.name_role
  create_devops_policy  = true
  ecr_repositories      = [module.ecr_server.ecr_repository_arn]
  code_deploy_resources = [module.codedeploy_server.application_arn, module.codedeploy_server.deployment_group_arn]
}

# ------- Creating the server CodeDeploy project -------
module "codedeploy_server" {
  source          = "./Modules/CodeDeploy"
  name            = "Deploy-${var.environment_name}-server"
  ecs_cluster     = module.ecs_cluster.ecs_cluster_name
  ecs_service     = module.ecs_service_server.ecs_service_name
  alb_listener    = module.alb_server.arn_listener
  tg_blue         = module.target_group_server_blue.tg_name
  tg_green        = module.target_group_server_green.tg_name
  codedeploy_role = module.codedeploy_role.arn_role_codedeploy
}


# ------- Creating Bucket to store assets accessed by the Back-end and Webhosting -------
module "s3_assets" {
  source      = "./Modules/S3"
  bucket_name = "assets-${var.aws_region}-${random_id.RANDOM_ID.hex}"
}