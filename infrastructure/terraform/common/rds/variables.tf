variable "deployment_env" {}

variable "subnet_ids" {
  description = "List containing subnet ids to be used in the sub net parameter groups"
  type        = list(string)
}

variable "rds_sg_id" {}