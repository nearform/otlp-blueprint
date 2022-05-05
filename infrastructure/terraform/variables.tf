# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "aws_region" {
  description = "The AWS Region in which you want to deploy the resources"
  type        = string
}

variable "environment_name" {
  description = "The name of your environment"
  type        = string

  validation {
    condition     = length(var.environment_name) < 23
    error_message = "Due the this variable is used for concatenation of names of other resources, the value must have less than 23 characters."
  }
}

variable "port_app_server" {
  description = "The port used by your server application"
  type        = number
  default     = 3000
}

variable "buildspec_path" {
  description = "The location of the buildspec file."
  type        = string
  default     = "./samples/3-tier/Infrastructure/Templates/buildspec.yml"
}

variable "folder_path_server" {
  description = "The location of the server files"
  type        = string
  default     = "./samples/3-tier/Code/server/."
}

variable "container_name" {
  description = "The name of the container of each ECS service"
  type        = map(string)
  default = {
    server = "Container-server"
  }
}

variable "iam_role_name" {
  description = "The name of the IAM Role for each service"
  type        = map(string)
  default = {
    devops        = "DevOps-Role"
    ecs           = "ECS-task-excecution-Role"
    ecs_task_role = "ECS-task-Role"
    codedeploy    = "CodeDeploy-Role"
  }
}
