variable "deployment_env" {}
variable "deployment_app_name" {}
variable "deployment_parent_dir" {}
variable "deployment_region" {}

variable "subnet_ids" {
    type = set(string)
}

variable "rds_sg_id" {}
