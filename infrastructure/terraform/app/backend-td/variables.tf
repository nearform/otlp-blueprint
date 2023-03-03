variable "tags" {
  type = map(any)
}

variable "deployment_region" {}

variable "deployment_env" {}

variable "deployment_app_name" {}

variable "vpc_id" {}

variable "public_subnet_ids" {
  type = set(string)
}

variable "private_subnet_ids" {
  type = set(string)
}

variable "sg_alb_id" {}

variable "sg_ecs_id" {}

variable "ecs_task_execution_role_arn" {}
variable "ecs_task_execution_role_id" {}

variable "sample_nginx_app_target_group_id" {}

variable "jaeger_app_target_group_id" {}

variable "otlp_fe_app_target_group_id" {}

variable "otlp_be_app_target_group_id" {}

variable "otlp_collector_app_target_group_id" {}

variable "secrets_arn" {
  sensitive = true
}

variable "app_image" {
  description = "The container image to use"
}

# Below need to be fed from terragrunt config later.
variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}
variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "ecs_cluster_id" {}

variable "otlp_log_group_name" {}

variable "ecs_service_discovery_namespace_id" {}
