variable "deployment_env" {}
variable "deployment_parent_dir" {}

variable "subnet_ids" {
    type = set(string)
}

variable "rds_sg_id" {}
