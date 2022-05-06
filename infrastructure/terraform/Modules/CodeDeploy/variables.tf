# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name" {
  description = "The name of the CodeDeploy application"
  type        = string
}

variable "ecs_cluster" {
  description = "The name of the ECS cluster where to deploy"
  type        = string
}

variable "ecs_service" {
  description = "The name of the ECS service to deploy"
  type        = string
}

variable "alb_listener" {
  description = "The ARN of the ALB listener for production"
  type        = string
}

variable "tg_blue" {
  description = "The Target group name for the Blue part"
  type        = string
}

variable "tg_green" {
  description = "The Target group name for the Green part"
  type        = string
}

variable "codedeploy_role" {
  description = "The role to be assumed by CodeDeploy"
  type        = string
}