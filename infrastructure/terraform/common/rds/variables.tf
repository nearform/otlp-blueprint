variable "deployment_env" {}

variable "subnet_ids" {
    type = set(string)
}

variable "rds_sg_id" {}